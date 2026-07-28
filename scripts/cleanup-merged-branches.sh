#!/usr/bin/env bash
#
# cleanup-merged-branches.sh — delete remote claude/* branches whose work is
# already merged into the default branch.
#
# Run this from your own machine (branch deletion is blocked from Claude's
# remote sandbox). Dry-run by default:
#
#   ./scripts/cleanup-merged-branches.sh            # list what would be deleted
#   ./scripts/cleanup-merged-branches.sh --delete   # actually delete (asks first)
#
# A branch counts as merged if either:
#   a) its commits are ancestors of the default branch (regular merge), or
#   b) the GitHub API reports a merged pull request for it — this also catches
#      squash- and rebase-merged branches, which (a) cannot see.
#
# Check (b) needs API access, from either of these — no install required for
# the second one:
#   - the GitHub CLI (gh), logged in; or
#   - a token in $GITHUB_TOKEN (or $GH_TOKEN), used via curl:
#       GITHUB_TOKEN=ghp_xxx ./scripts/cleanup-merged-branches.sh
#
# Override the defaults with env vars: REMOTE=origin PREFIX=claude/

set -euo pipefail

REMOTE="${REMOTE:-origin}"
PREFIX="${PREFIX:-claude/}"
DO_DELETE=false
[[ "${1:-}" == "--delete" ]] && DO_DELETE=true

DEFAULT=$(git remote show "$REMOTE" | sed -n 's/.*HEAD branch: //p')
[[ -n "$DEFAULT" ]] || { echo "error: could not determine default branch" >&2; exit 1; }

# Fetch explicit refspecs so this works even in a single-branch clone.
git fetch --prune "$REMOTE" \
  "+refs/heads/$DEFAULT:refs/remotes/$REMOTE/$DEFAULT" \
  "+refs/heads/${PREFIX}*:refs/remotes/$REMOTE/${PREFIX}*" >/dev/null 2>&1

SLUG=$(git remote get-url "$REMOTE" | sed -E 's#^.*github\.com[:/]##; s#\.git$##')
TOKEN="${GITHUB_TOKEN:-${GH_TOKEN:-}}"

if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  API_MODE=gh
elif [[ -n "$TOKEN" ]]; then
  API_MODE=curl
else
  API_MODE=none
  echo "note: no GitHub API access (no gh login, no \$GITHUB_TOKEN) —" >&2
  echo "      squash-merged branches will not be detected." >&2
fi

# Echoes a reason when the branch has a merged pull request, nothing otherwise.
merged_via_pr() {
  local br="$1"
  case "$API_MODE" in
    gh)
      local n
      n=$(gh pr list --head "$br" --state merged --json number --jq 'length' 2>/dev/null || echo 0)
      [[ "$n" -gt 0 ]] && echo "merged via pull request (squash/rebase)"
      ;;
    curl)
      curl -fsS -H "Authorization: Bearer $TOKEN" \
        -H "Accept: application/vnd.github+json" \
        "https://api.github.com/repos/$SLUG/pulls?head=${SLUG%%/*}:$br&state=closed&per_page=100" 2>/dev/null \
        | grep -q '"merged_at": *"' && echo "merged via pull request (squash/rebase)"
      ;;
  esac
}

DELETABLE=""
COUNT=0
for BR in $(git for-each-ref --format='%(refname:strip=3)' "refs/remotes/$REMOTE/$PREFIX"); do
  REASON=""
  if git merge-base --is-ancestor "refs/remotes/$REMOTE/$BR" "refs/remotes/$REMOTE/$DEFAULT"; then
    REASON="merged (ancestor of $DEFAULT)"
  else
    REASON=$(merged_via_pr "$BR" || true)
  fi
  if [[ -n "$REASON" ]]; then
    DELETABLE="$DELETABLE $BR"
    COUNT=$((COUNT + 1))
    printf '%-60s %s\n' "$BR" "$REASON"
  fi
done

if [[ "$COUNT" -eq 0 ]]; then
  echo "No merged ${PREFIX}* branches found on $REMOTE."
  exit 0
fi

if ! $DO_DELETE; then
  echo
  echo "Dry run: $COUNT branch(es) would be deleted. Re-run with --delete to remove them."
  exit 0
fi

echo
printf 'Delete these %d remote branch(es)? [y/N] ' "$COUNT"
read -r ANSWER
[[ "$ANSWER" == [yY]* ]] || { echo "Aborted."; exit 1; }

for BR in $DELETABLE; do
  git push "$REMOTE" --delete "$BR"
done
echo "Done: $COUNT branch(es) deleted."
