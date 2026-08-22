# Go Upstream AB — goupstream.se

## What this repo is for

Two things. It holds the public site at goupstream.se (see below), and it is
where ideas for the company get thought through — a lot of the work here is
conversation, not markup. Don't assume a session is about the website.

Go Upstream AB owns the projects it runs: `OSW`, `Helny` and `ABkoll`, in
sibling repos under the same org. `drilla` is not one of them — it belongs to
George's brother Mats, with George contributing, so don't treat it as a company
asset.

New ideas are weighed against three things: do they grow the company's assets,
do they strengthen its competitive position, and are they the kind of work that
attracts young entrepreneurial talent.

## The site

One static page served by GitHub Pages. No framework, no build step, no
dependencies, no tests. Preview with `python3 -m http.server` in the repo root.

Everything lives in `index.html`: the CSS in a single `<style>` block, and one
small `<script>` for the privacy modal. This is deliberate — do not split the
CSS or JS into separate files, and do not introduce a build step or a package
manager.

Colours, fonts and spacing come from the `--gu-*` tokens in `:root`. Use the
tokens; don't hardcode hex values. Comments marked `▼` flag the copy most
likely to need editing (stats, engagement cards, contact details).

## Don't break these

- **`CNAME`** holds the custom domain. Deleting it drops goupstream.se.
- **No third-party requests.** No analytics, no CDN, no Google Fonts. The
  privacy modal tells visitors this, so it has to stay true.
- **`fonts/`** is self-hosted woff2 plus the OFL licence texts. If you refresh
  a subset, keep the `unicode-range` values in `index.html` and the table in
  `fonts/README.md` in sync.
- **`assets/`** filenames encode their dimensions (`og-image-1200x630.png`).
  Regenerate at the same size or rename everywhere.
