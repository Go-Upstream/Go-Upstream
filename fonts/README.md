# Fonts

Self-hosted so the site makes no third-party requests. Nothing here is loaded
from Google Fonts or any other external domain.

| File | Family | Weight |
| --- | --- | --- |
| `familjen-grotesk-latin.woff2` | Familjen Grotesk (variable) | 400–700 |
| `familjen-grotesk-latin-ext.woff2` | Familjen Grotesk (variable) | 400–700 |
| `ibm-plex-mono-latin-400.woff2` | IBM Plex Mono | 400 |
| `ibm-plex-mono-latin-ext-400.woff2` | IBM Plex Mono | 400 |
| `ibm-plex-mono-latin-500.woff2` | IBM Plex Mono | 500 |
| `ibm-plex-mono-latin-ext-500.woff2` | IBM Plex Mono | 500 |

The `latin-ext` files are gated by `unicode-range` and are only downloaded if a
character outside Latin-1 appears on the page.

Both families are licensed under the SIL Open Font License 1.1; the full licence
texts are in `OFL-Familjen-Grotesk.txt` and `OFL-IBM-Plex-Mono.txt`.

- Familjen Grotesk — Copyright 2021 The Familjen Grotesk Project Authors
- IBM Plex Mono — Copyright © 2017 IBM Corp. with Reserved Font Name "Plex"

Subsets were taken from the Google Fonts CDN builds. To refresh them, re-fetch
the `woff2` URLs from `https://fonts.googleapis.com/css2?family=...` and keep the
`unicode-range` values in `index.html` in sync.
