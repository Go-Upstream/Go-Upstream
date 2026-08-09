# Ordlista för utvecklarspråket

En uppslagsbok över de ord, begrepp och system som dyker upp när vi utvecklar
tillsammans. Termerna står kvar på engelska — det är så de heter i verktygen och
i alla sökresultat — men förklaringarna är på svenska.

Listan täcker samtliga repon i `Go-Upstream`:

| Repo | Vad | Stack |
| --- | --- | --- |
| `Go-Upstream` | goupstream.se | Statisk HTML/CSS på GitHub Pages |
| `ABkoll` | Bolagsöversikt med webb och app | Next.js · Supabase · Expo · Astro · Vercel |
| `drilla` | Beställning och lager för dentala kliniker | Next.js · Supabase · Tailwind |
| `Helny` | Mobilapp med försäljningsintegrationer | Expo/React Native · Supabase |
| `roadmap` | Delad roadmap-motor som de andra hämtar | TypeScript, publiceras som artefakt |
| `membrain-strategy` | Ett strategidokument, ingen kod | — |

Avsnitt 1–12 är grunderna som gäller överallt. Avsnitt 13–24 är det som tillkommer
i app-repona: ramverk, databas, mobil, drift och era egna system.

Rader markerade **Här:** pekar på var saken faktiskt finns i koden.

---

## 1. Git — versionshantering

Git är systemet som håller reda på varje ändring i koden, vem som gjorde den och
när. Allt annat i arbetsflödet vilar på det.

- **Repository (repo)** — hela projektet plus dess kompletta historik. *Här:* `Go-Upstream/Go-Upstream`.
- **Clone** — att hämta hem en egen komplett kopia av ett repo, historiken inkluderad.
- **Working directory** — filerna som de ser ut på disken just nu, innan något sparats i historiken.
- **Staging area (index)** — mellanlagret där du väljer exakt vilka ändringar som ska ingå i nästa commit. `git add` lägger saker här.
- **Commit** — en sparad, namngiven ändring. Den minsta enheten i historiken, med en unik id (`5f6b44b`) och ett meddelande.
- **Commit message** — texten som förklarar *varför* ändringen gjordes. Första raden är rubriken; håll den kort och i imperativ ("Add a script…", inte "Added…").
- **Diff** — skillnaden mellan två versioner, rad för rad. `+` är tillagt, `-` är borttaget.
- **Hunk** — ett sammanhängande stycke i en diff, med några oförändrade rader runtomkring som sammanhang.
- **Branch (gren)** — en namngiven parallell utvecklingslinje. Du kan bygga färdigt i lugn och ro utan att röra det som är publicerat.
- **Default branch** — grenen som är "sanningen", den som publiceras. *Här:* `main`.
- **Feature branch** — en tillfällig gren för ett avgränsat arbete, som slås ihop och slängs efteråt. *Här:* alla `claude/*`-grenar.
- **HEAD** — pekaren till var du står just nu, oftast längst ut på den gren du checkat ut.
- **Checkout / switch** — att byta till en annan gren eller version.
- **Merge** — att slå ihop en gren med en annan. Skapar oftast en extra "merge commit" som knyter ihop de två linjerna.
- **Fast-forward** — en merge utan merge commit, möjlig när ingen annan hunnit ändra något under tiden. Pekaren flyttas bara framåt.
- **Squash merge** — alla commits i grenen pressas ihop till en enda innan de landar i `main`. Ger en ren historik, men den ursprungliga grenen syns inte längre som förfader.
- **Rebase** — att flytta sina commits så att de ser ut att ha byggts ovanpå den senaste versionen av `main`. Ger en rak historik i stället för en förgrenad.
- **Merge conflict** — när två grenar ändrat samma rader och Git inte kan avgöra vilken som gäller. Måste lösas för hand.
- **Ancestor** — en commit som ligger bakåt i historiken från en annan. Att en gren är "merged" betyder normalt att dess commits blivit förfäder till `main`.
- **Remote** — ett repo som ligger någon annanstans, oftast på GitHub.
- **origin** — standardnamnet på den remote du klonade ifrån.
- **upstream** — namnet man brukar ge originalrepot när man jobbar i en fork. (Inte att förväxla med bolagsnamnet.)
- **Fetch** — hämta hem nyheter från remoten utan att ändra dina egna filer.
- **Pull** — fetch plus merge i ett steg: hämta hem *och* väv in.
- **Push** — skicka upp dina commits till remoten.
- **Force push** — skriva över remotens historik. Farligt; `--force-with-lease` är den säkra varianten som vägrar om någon annan hunnit lägga till något.
- **Refspec** — den exakta kartläggningen mellan grenar lokalt och på remoten, t.ex. `+refs/heads/main:refs/remotes/origin/main`. *Här:* används i städskriptet för att fungera även i en klon med bara en gren.
- **Prune** — rensa bort lokala spår av grenar som inte längre finns på remoten.
- **Tag** — en fast etikett på en viss commit, oftast en versionsmärkning.
- **Stash** — att tillfälligt lägga undan ändringar du inte vill committa än.
- **Cherry-pick** — plocka en enskild commit från en gren och lägga den på en annan.
- **Revert** — göra en ny commit som upphäver en tidigare. Historiken bevaras.
- **Reset** — flytta tillbaka pekaren och (beroende på flagga) kasta ändringar. Skriver om historik, till skillnad från revert.
- **`.gitignore`** — lista över filer Git ska låtsas inte finnas, t.ex. byggresultat och hemligheter.
- **Monorepo** — ett enda repo som rymmer flera projekt. Motsatsen är ett repo per projekt.

---

## 2. GitHub — samarbete och granskning

GitHub är tjänsten runt Git: där koden bor, granskas och publiceras.

- **Pull request (PR)** — ett förslag: "slå ihop den här grenen med `main`". Platsen där ändringen diskuteras och granskas innan den landar.
- **Draft PR** — en PR märkt som pågående arbete, inte redo att slås ihop.
- **Review** — en granskning med utfall: *approve*, *request changes* eller bara *comment*.
- **Inline comment** — en kommentar knuten till en specifik rad i diffen, till skillnad från en allmän kommentar i tråden.
- **Review thread** — en kommentarstråd på en rad. Kan markeras som *resolved* när frågan är hanterad.
- **Issue** — ett ärende: en bugg, en idé, en uppgift. Inte kopplat till kod på samma sätt som en PR.
- **Label** — färgad etikett för att sortera issues och PR:er.
- **Assignee / reviewer** — den som äger arbetet respektive den som ombeds granska.
- **Fork** — en egen kopia av ett repo under ditt eget konto, för att bidra utan skrivrättigheter i originalet.
- **Branch protection** — regler som hindrar direkta pushar till `main` och kräver granskning eller grön CI först.
- **CODEOWNERS** — fil som pekar ut vem som automatiskt sätts som granskare för vissa filer.
- **PR template** — färdig mall som fyller PR-beskrivningen med rubriker att fylla i.
- **CI (continuous integration)** — automatiska kontroller som körs på varje ändring: tester, linting, bygge.
- **GitHub Actions** — GitHub:s inbyggda CI-system. Konfigureras i `.github/workflows/*.yml`. *Här:* inget i `Go-Upstream` — sajten är statisk och publiceras direkt — men 34 arbetsflöden i de andra repona. Se avsnitt 21.
- **Workflow / job / step** — hierarkin i Actions: ett flöde består av jobb, som består av steg.
- **Check run / status check** — en enskild kontroll och dess resultat (grön/röd) på en commit eller PR.
- **Auto-merge** — låt GitHub slå ihop PR:en automatiskt så snart alla krav är gröna.
- **Merge queue** — kö som testar PR:er mot varandra innan de landar, så att `main` aldrig går sönder.
- **Webhook** — ett automatiskt anrop utåt när något händer (ny kommentar, misslyckad CI). Så får en session veta att något hänt utan att fråga hela tiden.
- **GitHub API** — det programmerbara gränssnittet mot allt ovanstående.
- **`gh`** — GitHub:s kommandoradsverktyg, ett bekvämare skal runt API:et. *Här:* städskriptet använder `gh` om det finns, annars `curl` med en token.
- **Personal access token (PAT)** — en nyckel som ger ett skript rätt att agera i ditt namn mot API:et. Ska aldrig committas. *Här:* läses ur `$GITHUB_TOKEN`.
- **Squash-and-merge-fällan** — en gren som squash-mergats syns inte som förfader till `main`, så vanlig "är den merged?"-logik missar den. Man måste fråga API:et om PR-status. *Här:* precis det problem `scripts/cleanup-merged-branches.sh` löser.

---

## 3. Publicering — hosting, domän och DNS

- **Static site** — en sajt som består av färdiga filer (HTML, CSS, bilder) utan server som räknar ut något vid varje besök. *Här:* hela goupstream.se.
- **GitHub Pages** — GitHub:s gratishosting för statiska sajter direkt från ett repo. Push till `main` = publicerat.
- **`CNAME`-filen** — filen i repotroten som talar om för GitHub Pages vilken egen domän sajten ska svara på. *Här:* innehåller `goupstream.se`.
- **DNS** — internets adressbok, som översätter `goupstream.se` till en serveradress.
- **A-record / CNAME-record** — de två posttyperna i DNS: en pekar på en IP-adress, den andra på ett annat domännamn. (DNS-posten `CNAME` och Git-grenar har inget med varandra att göra — samma ord, olika världar.)
- **TTL** — hur länge en DNS-post får mellanlagras. Därför slår domänändringar inte igenom direkt.
- **HTTPS / TLS-certifikat** — krypteringen som ger hänglåset i adressfältet. GitHub Pages utfärdar det åt oss automatiskt.
- **CDN** — nätverk av servrar nära besökaren som levererar filerna snabbt. GitHub Pages ligger bakom ett.
- **Cache** — mellanlagrad kopia. Skälet till att en ändring ibland inte syns förrän du laddar om hårt (Cmd/Ctrl + Shift + R).
- **404** — HTTP-koden för "finns inte". En egen `404.html` blir automatiskt felsidan.
- **Deploy** — att få ut en ny version i produktion. *Här:* synonymt med att pusha till `main`.

---

## 4. HTML — sidans struktur

- **HTML** — språket som beskriver sidans innehåll och struktur.
- **Element / tag / attribut** — `<a href="...">Text</a>`: elementet är `a`, taggarna är `<a>` och `</a>`, `href` är ett attribut.
- **Void element** — element utan sluttagg, som `<meta>`, `<link>` och `<img>`.
- **DOM** — webbläsarens levande trädmodell av sidan. Det JavaScript läser och ändrar i.
- **Semantic HTML** — att använda element efter betydelse (`<header>`, `<nav>`, `<section>`, `<footer>`) i stället för `<div>` överallt. Hjälper både sökmotorer och skärmläsare. *Här:* sidan är uppbyggd av `<section>`-block med `id` för ankarlänkarna.
- **`id` och `class`** — `id` är unikt på sidan och används för länkmål och JS; `class` är återanvändbar och används för styling. *Här:* `#about`, `#engagements`, `.section`, `.wrap`.
- **Anchor link** — en länk till ett `id` på samma sida, t.ex. `#contact`. Driver menyn.
- **`<head>` vs `<body>`** — huvudet innehåller information *om* sidan (titel, metadata, stil), kroppen innehåller det man ser.
- **`<dialog>`** — inbyggt HTML-element för modaler, med `.showModal()` och `.close()`. *Här:* integritetsrutan i sidfoten.
- **Modal** — en ruta som lägger sig över sidan och tar fokus tills den stängs.
- **Entity** — kodad tecknbeteckning i HTML, t.ex. `&amp;` för `&`. Nödvändigt eftersom `&` och `<` har egen betydelse i märkspråket.

---

## 5. CSS — utseende, layout och design tokens

- **CSS** — språket som bestämmer hur allting ser ut.
- **Selector** — det som pekar ut vad regeln gäller: `.section`, `a:hover`, `h1`.
- **Declaration / property / value** — `color: #E9A924;` — egenskap och värde.
- **Cascade** — reglerna för vilken regel som vinner när flera pekar på samma element.
- **Specificity** — vikten hos en selector. `#id` slår `.class` som slår `h1`. Den vanligaste orsaken till "varför tar min CSS inte?".
- **Inheritance** — att vissa egenskaper (som färg och typsnitt) ärvs nedåt i trädet, medan andra (som marginaler) inte gör det.
- **Custom property / CSS-variabel** — ett namngivet värde, `--gu-gold: #E9A924`, som återanvänds med `var(--gu-gold)`.
- **Design tokens** — den samlade uppsättningen namngivna designbeslut: färger, typsnitt, avstånd, radier. Ett enda ställe att ändra på. *Här:* hela `:root`-blocket, alla med prefixet `--gu-`.
- **Box model** — varje element är en låda: innehåll, `padding` (innanför kanten), `border`, `margin` (utanför).
- **`box-sizing: border-box`** — gör att angiven bredd inkluderar padding och kant. Nästan alltid det man vill ha. *Här:* satt globalt.
- **Flexbox** — layout i en riktning (rad eller kolumn). Bra för menyrader och staplar.
- **Grid** — layout i två riktningar samtidigt. Bra för kortrutnät.
- **`gap`** — avståndet mellan syskon i flex/grid. Att låta layouten sköta luften i stället för marginaler på varje element gör spacingen förutsägbar.
- **`margin-inline: auto`** — centrerar ett block horisontellt. *Här:* det som håller `.wrap` mitt på sidan.
- **Media query** — regler som bara gäller under vissa villkor, oftast skärmbredd. *Här:* brytpunkter vid 900 px och 520 px.
- **Breakpoint** — bredden där layouten byter skepnad.
- **Responsive design** — att sidan fungerar från mobil till bred skärm.
- **Viewport** — den synliga ytan i webbläsaren. `<meta name="viewport">` är raden som gör att mobiler inte zoomar ut sidan.
- **`px`, `rem`, `ch`, `%`** — enheter: absoluta pixlar, relativt rotens teckenstorlek, bredden på tecknet "0", respektive andel av föräldern. *Här:* `--gu-measure: 62ch` sätter radlängden på löptext.
- **Measure** — radlängd i tecken. Runt 60–70 är läsbarhetsidealet.
- **Type scale** — den bestämda trappan av rubrikstorlekar, i stället för godtyckliga värden.
- **Pseudo-class** — tillstånd hos ett element: `:hover`, `:focus-visible`, `:last-of-type`.
- **`:focus-visible`** — markeringen som visas när man tabbar sig fram med tangentbord, men inte vid musklick. *Här:* guldram med `outline-offset`.
- **Transition** — mjuk övergång mellan två tillstånd, t.ex. färgskifte vid hover.
- **Inline CSS vs external stylesheet** — stil i samma fil som HTML respektive i en egen `.css`-fil. *Här:* allt ligger inline i `index.html`, vilket sparar ett nätverksanrop på en enfilssajt.
- **Minification** — att komprimera bort blanksteg och kommentarer inför publicering.
- **Tailwind** — CSS-ramverk där man sätter färdiga småklasser direkt i märkspråket (`flex gap-4 text-sm`) i stället för att skriva egna regler. *Här:* drilla. Go Upstream-sajten gör tvärtom och skriver egen CSS.
- **Utility-first** — principen bakom Tailwind: många små enkelsyftesklasser i stället för få semantiska.
- **`@theme`** — Tailwind 4:s block för att definiera projektets tokens. Samma idé som `:root`-variablerna på Go Upstream-sajten, andra syntax.
- **`dark:`, `sm:`, `md:`** — Tailwinds prefix för mörkt läge och brytpunkter, i stället för media queries.

---

## 6. JavaScript — beteende

- **JavaScript (JS)** — språket som gör sidan interaktiv.
- **Script tag** — `<script>`, där koden ligger eller laddas in.
- **`defer` / `async`** — attribut som styr när ett externt skript körs, så att det inte blockerar sidans uppritning.
- **Event listener** — kod som väntar på att något ska hända: `addEventListener('click', ...)`.
- **Event / event target** — själva händelsen och elementet den utgick från. *Här:* modalen stängs när klicket träffar bakgrunden i stället för innehållet.
- **IIFE** — ett funktionsuttryck som körs direkt, `(function(){ ... })()`. Håller variabler för sig själva i stället för att lägga dem globalt.
- **Scope** — var en variabel är synlig.
- **Console** — utvecklarverktygens loggfönster; första stället att titta när något inte händer.
- **DevTools** — webbläsarens inbyggda inspektionsverktyg (F12). Elementpanelen, konsolen, nätverkspanelen.

---

## 7. Typsnitt, bilder och assets

- **Asset** — en statisk fil som hör till sajten: bild, typsnitt, ikon. *Här:* mappen `assets/`.
- **`woff2`** — det komprimerade webbformatet för typsnitt. Minst och snabbast.
- **Variable font** — ett typsnitt där en fil täcker ett helt viktspann. *Här:* Familjen Grotesk 400–700 i en enda fil.
- **`@font-face`** — CSS-regeln som registrerar ett eget typsnitt.
- **Self-hosting** — att lägga typsnitten i eget repo i stället för att hämta dem från Google Fonts. Gör att sajten inte skickar besökardata till tredje part. *Här:* uttalad princip, se `fonts/README.md`.
- **`font-display: swap`** — visa texten direkt i ett reservtypsnitt och byt när det riktiga laddats, i stället för att låta texten vara osynlig.
- **`unicode-range`** — talar om vilka tecken en typsnittsfil täcker, så att webbläsaren bara laddar den om de tecknen faktiskt används. *Här:* `latin-ext`-filerna laddas bara vid tecken utanför Latin-1.
- **Subsetting** — att beskära ett typsnitt till bara de tecken som behövs.
- **Fallback stack** — reservtypsnitten efter det önskade: `'Familjen Grotesk', Helvetica, Arial, sans-serif`.
- **OFL (SIL Open Font License)** — den licens båda typsnitten här ligger under; tillåter fri användning men kräver att licenstexten följer med. *Här:* `fonts/OFL-*.txt`.
- **Favicon** — den lilla ikonen i webbläsarfliken. `favicon.ico` i roten är den bakåtkompatibla varianten; PNG-varianter anges separat.
- **`apple-touch-icon`** — ikonen som används när någon sparar sajten på en iPhone-hemskärm. 180×180.
- **OG-bild** — förhandsbilden som visas när länken delas. 1200×630 är standardmåttet. *Här:* `assets/og-image-1200x630.png`.
- **Raster vs vektor** — PNG/JPG är rutnät av pixlar och blir suddiga vid förstoring; SVG är matematiska former och skalar obegränsat.
- **`alt`-text** — textbeskrivningen av en bild, för skärmläsare och för när bilden inte laddas.
- **`srcset`** — låter webbläsaren välja rätt bildstorlek för skärmen.
- **Lazy loading** — `loading="lazy"` skjuter upp inläsningen av bilder långt ned på sidan.
- **`object-fit`** — hur en bild ska fylla sin ruta: `cover` beskär, `contain` krymper in hela.

---

## 8. Metadata och SEO

- **SEO** — allt som gör sidan begriplig för sökmotorer.
- **`<title>`** — sidans titel i fliken och som rubrik i sökresultatet.
- **Meta description** — den beskrivande texten under rubriken i sökresultatet.
- **Canonical URL** — beskedet "det här är den riktiga adressen för det här innehållet", som hindrar att dubbletter konkurrerar med varandra.
- **Open Graph (`og:`)** — Facebooks metadataformat som numera alla använder för länkförhandsvisningar: titel, beskrivning, bild.
- **Twitter Card** — motsvarande för X/Twitter. `summary_large_image` ger den stora bilden.
- **`theme-color`** — färgar webbläsarens ram på mobil. *Här:* `#191612`.
- **`lang`-attribut** — sidans språk, för skärmläsare och sökmotorer.
- **`robots.txt`** — instruktioner om vad sökmotorer får indexera.
- **Sitemap** — maskinläsbar innehållsförteckning över sajtens sidor.
- **Structured data / schema.org** — extra maskinläsbar märkning (organisation, person, adress) som kan ge rikare sökresultat.

---

## 9. Tillgänglighet (a11y)

*(a11y = "accessibility" med de elva mellanbokstäverna utbytta mot en siffra. Samma trick som i18n och l10n.)*

- **Screen reader** — programmet som läser upp sidan för den som inte ser den. Den viktigaste anledningen till semantisk HTML.
- **ARIA** — extra attribut som beskriver roller och tillstånd när HTML inte räcker till.
- **`aria-label`** — ett läsbart namn på något som saknar synlig text, t.ex. en menyregion eller en ikonknapp. *Här:* `aria-label="Primary"` på navigeringen.
- **Landmark** — de stora regionerna (`header`, `nav`, `main`, `footer`) som gör att man kan hoppa mellan avsnitt med skärmläsare.
- **Focus order** — ordningen tabbtangenten går igenom sidan. Ska följa den visuella ordningen.
- **Focus indicator** — den synliga markeringen av var tangentbordsfokus är. Får aldrig tas bort utan ersättning.
- **Skip link** — en dold länk först på sidan, "hoppa till innehållet", som låter tangentbordsanvändare förbi menyn.
- **Kontrastkrav (WCAG AA)** — text ska ha minst 4,5:1 i kontrast mot bakgrunden, stor text 3:1. Detta styr vilka guldnyanser som får användas mot vilken botten. *Här:* därför finns både `--gu-gold` och den mörkare `--gu-gold-light` för ljus botten.
- **`prefers-reduced-motion`** — systeminställningen för den som blir illamående av rörelse. Animationer ska stängas av när den är på. *Här:* respekterad.
- **`prefers-color-scheme`** — systeminställningen ljust/mörkt läge.
- **Touch target** — klickytans storlek. Under ~44×44 px blir den svårträffad på mobil.

---

## 10. Prestanda

- **Lighthouse** — mätverktyget i Chrome DevTools som ger poäng på prestanda, tillgänglighet, SEO.
- **Core Web Vitals** — Googles tre nyckeltal: **LCP** (hur snabbt det största innehållet syns), **CLS** (hur mycket sidan hoppar under laddning), **INP** (hur snabbt sidan svarar på klick).
- **Render-blocking** — resurser som stoppar uppritningen tills de laddats. Externa CSS-filer och skript utan `defer` är de vanliga bovarna.
- **`preload`** — beskedet "börja hämta det här direkt, det behövs snart". *Här:* de två typsnittsfiler som syns direkt vid sidladdning.
- **`crossorigin`** — krävs på typsnitts-preloads, annars hämtas filen två gånger.
- **FOUT / FOIT** — "flash of unstyled/invisible text": den korta stunden innan rätt typsnitt är på plats.
- **Payload / bundle size** — den totala vikten besökaren laddar ned.
- **Roundtrip** — ett anrop fram och tillbaka till servern. Färre är snabbare — därför ligger CSS:en inline här.

---

## 11. Att jobba med Claude Code

- **Claude Code** — verktyget du pratar med när vi utvecklar. Finns som terminalkommando, skrivbordsapp, webbapp och IDE-tillägg.
- **Session** — en pågående konversation med tillhörande arbetskatalog och historik.
- **Remote session / sandbox** — den här sessionen kör i en isolerad container i molnet, inte på din dator. Repot klonades färskt när den startade och containern återvinns efteråt — **det som inte är committat och pushat är borta**.
- **Environment** — den förkonfigurerade miljön en session startar i: nätverkspolicy, miljövariabler, startskript.
- **Working directory** — katalogen sessionen utgår ifrån. *Här:* `/home/user/Go-Upstream`.
- **Context window** — hur mycket text jag kan ha i huvudet samtidigt. När den fylls sammanfattas det äldsta.
- **Token** — den enhet text mäts i, ungefär en halv till ett ord. Både längd och kostnad räknas i tokens.
- **Prompt** — instruktionen du ger. **System prompt** är de stående instruktionerna sessionen startar med.
- **Tool call** — när jag använder ett verktyg (läsa fil, köra kommando, söka) i stället för att bara skriva text.
- **Permission mode** — hur mycket jag får göra utan att fråga först. Nekade anrop betyder att du sagt nej, inte att något gick sönder.
- **Plan mode** — läge där jag utreder och lägger fram en plan för godkännande innan något ändras.
- **Subagent** — en avgränsad hjälpsession som får en egen uppgift, kör parallellt och rapporterar tillbaka.
- **Skill** — ett paketerat arbetssätt jag kan ladda in, ofta anropat med snedstreck: `/code-review`, `/simplify`.
- **Slash command** — kommandon som skrivs med inledande snedstreck.
- **Hook** — automatik som körs vid bestämda tillfällen i sessionen, t.ex. en `SessionStart`-hook som installerar beroenden.
- **MCP (Model Context Protocol)** — standarden som kopplar in externa system som verktyg. *Här:* GitHub, Google Drive och Gmail är anslutna som MCP-servrar.
- **`CLAUDE.md`** — projektets egen instruktionsfil, som läses automatiskt och beskriver konventioner jag ska följa.
- **Artifact** — en publicerad, privat webbsida på claude.ai som du kan välja att dela vidare.
- **Scratchpad** — sessionens tillfälliga arbetskatalog, utanför ditt projekt. För kladd som inte ska committas.
- **`claude/*`-grenar** — namnkonventionen för de grenar arbetet här sker på, t.ex. `claude/developer-glossary-ug3k0m`. Suffixet är slumpat så att två uppgifter aldrig krockar. *Här:* det städskriptet städar bort.

---

## 12. Terminal, skript och allmän jargong

- **Shell / terminal** — textgränssnittet mot datorn. `bash` är skalet skripten här är skrivna för.
- **CLI** — kommandoradsverktyg, till skillnad från grafiskt gränssnitt (GUI).
- **Flag / option / argument** — `./skript.sh --delete`: `--delete` är en flagga, det som följer utan streck är argument.
- **Shebang** — första raden i ett skript, `#!/usr/bin/env bash`, som talar om vilket program som ska köra det.
- **`chmod +x`** — gör en fil körbar. Utan det går skriptet inte att starta direkt.
- **`set -euo pipefail`** — standardraden som gör bash strängt: avbryt vid fel, avbryt vid odefinierad variabel, låt fel mitt i en pipe räknas. *Här:* i städskriptet.
- **Exit code** — programmets svar på om det gick bra. `0` = lyckades, allt annat = fel.
- **stdout / stderr** — de två utflödena: vanlig utskrift respektive felmeddelanden. `2>/dev/null` tystar det senare.
- **Pipe (`|`)** — skickar ett programs utdata direkt in i nästa.
- **Environment variable** — värde som sätts utanför programmet och läses in av det, t.ex. `GITHUB_TOKEN=... ./skript.sh`. Standardsättet att skicka in hemligheter utan att skriva dem i koden.
- **Absolut vs relativ sökväg** — `/home/user/Go-Upstream/index.html` respektive `assets/favicon-32.png`, räknat från nuvarande plats.
- **Dry run** — att köra ett verktyg i "visa vad som skulle hända"-läge utan att ändra något. *Här:* städskriptets standardläge — det raderar inget förrän du säger `--delete`.
- **Idempotent** — en operation som ger samma resultat hur många gånger den än körs.
- **Refactor** — att skriva om kod så att den blir tydligare utan att beteendet ändras.
- **Regression** — något som fungerade förut men gått sönder av en ny ändring.
- **Edge case** — det ovanliga specialfallet som avslöjar buggar: tom lista, väldigt långt namn, ingen nätverksuppkoppling.
- **Breaking change** — en ändring som gör att något som byggde på det gamla beteendet slutar fungera.
- **Technical debt** — genvägar som fungerar nu men kostar tid senare.
- **Boilerplate** — nödvändig standardkod utan eget innehåll.
- **Linter** — verktyg som anmärker på tveksam kod. **Formatter** — verktyg som formaterar om den automatiskt.
- **Smoke test** — den snabba grundkontrollen: startar det överhuvudtaget?
- **Semantic versioning (semver)** — `MAJOR.MINOR.PATCH`: brytande ändring, ny funktion, felrättning.
- **UTF-8** — teckenkodningen som får å, ä och ö att bli rätt. `<meta charset="utf-8">` är raden som garanterar det.
- **Whitespace** — blanksteg, tabbar och radbrytningar. Osynligt, men syns i diffar.

---

## 13. Node, npm och byggkedjan

- **Node.js** — miljön som kör JavaScript utanför webbläsaren. Allt bygge, alla skript och alla tester går genom den.
- **npm** — pakethanteraren. Hämtar hem andras kod och kör projektets skript.
- **`package.json`** — projektets deklaration: namn, beroenden och namngivna kommandon.
- **`scripts`** — de namngivna kommandona, körs med `npm run <namn>`. *Här:* `npm run roadmap`, `npm run db:reset`, `npm run typecheck`.
- **`dependencies` vs `devDependencies`** — det som behövs när koden kör skarpt, respektive det som bara behövs för att bygga och testa. Testramverk och typer hör till det senare.
- **Lockfile (`package-lock.json`)** — den exakta versionen av varje paket, ned till underberoenden. Det som gör att bygget blir likadant i dag som i går.
- **`npm ci` vs `npm install`** — `ci` installerar exakt vad lockfilen säger och rör den inte; `install` får uppdatera den. CI ska alltid använda `ci`.
- **Semver-intervall** — `^1.2.3` tillåter nya minor-versioner, `~1.2.3` bara patchar, `1.2.3` exakt.
- **Pinning** — att låsa ett beroende vid en exakt version eller commit i stället för ett intervall. *Här:* roadmap-motorn pinnas på en commithash, aldrig på en gren eller tagg.
- **Transitive dependency** — ett paket du inte bett om, som kom med för att något annat behövde det.
- **TypeScript** — JavaScript med typer. Fel som annars dyker upp hos användaren fångas när du skriver koden.
- **`tsconfig.json`** — kompilatorns inställningar: hur strikt, vilken målversion, vilka mappar.
- **Type / interface / generic** — namngiven form på data, kontrakt för ett objekt, respektive en typ som tar en annan typ som parameter (`Array<Bolag>`).
- **Type inference** — att kompilatorn räknar ut typen själv, så du slipper skriva den.
- **`any` / `unknown`** — flyktvägarna ur typsystemet. `any` stänger av kontrollen; `unknown` tvingar dig att kontrollera innan du använder värdet. Föredra `unknown`.
- **`.d.ts`** — typdeklarationer utan implementation, för bibliotek skrivna i ren JavaScript.
- **`typecheck`** — att köra kompilatorn enbart för att leta typfel, utan att producera något. En egen CI-kontroll.
- **`tsx`** — kör en TypeScript-fil direkt, utan byggsteg. *Här:* det alla `scripts/`-verktyg startas med.
- **ESM vs CommonJS** — de två modulsystemen: `import`/`export` respektive `require()`. Blandningen är källan till många kryptiska byggfel.
- **Bundler** — verktyget som buntar ihop många källfiler till få paket för webbläsaren. *Här:* Next.js egen för webben, **Metro** för mobilappen.
- **Transpilering** — att översätta modern kod till en äldre dialekt som fler miljöer förstår.
- **Tree shaking** — att kasta bort kod ingen använder ur det färdiga paketet.
- **Source map** — kartan tillbaka från byggd kod till originalraden, så att felmeddelanden pekar rätt.
- **ESLint** — verktyget som anmärker på tveksam kod utifrån regler. **Custom rule** — en egen regel för projektets egna misstag.
- **PostCSS** — steget som transformerar CSS under bygget. *Här:* det Tailwind hakar i.
- **Deno** — en annan JavaScript-miljö än Node, med inbyggd säkerhetsmodell. *Här:* det Supabases Edge Functions kör på — därför `deno.lock` bredvid `package-lock.json` i ABkoll.

---

## 14. React — komponenter och tillstånd

- **React** — biblioteket som bygger gränssnitt av små återanvändbara delar.
- **Component** — en funktion som returnerar gränssnitt. Byggstenen i allt.
- **JSX** — den HTML-liknande syntaxen inuti JavaScript. `className` i stället för `class`, eftersom `class` är upptaget.
- **Props** — data som skickas in i en komponent uppifrån. Läses, ändras aldrig inifrån.
- **State** — data komponenten äger själv och som får ändras. Ändras den ritas komponenten om.
- **Hook** — funktion som börjar på `use` och ger komponenten en förmåga. Får bara anropas överst i en komponent, aldrig i en if-sats eller loop.
- **`useState`** — det vanligaste tillståndet: ett värde plus en funktion som byter det.
- **`useEffect`** — kod som körs *efter* renderingen, för sådant som ligger utanför React. Ofta överanvänd; behövs mer sällan än man tror.
- **`useRef`** — en låda som överlever omritningar utan att utlösa någon. Används också för att peka på ett DOM-element.
- **`useMemo` / `useCallback`** — sparar ett uträknat värde respektive en funktion mellan renderingar. Optimering, inte standard.
- **`useTransition`** — märker en uppdatering som icke-brådskande så att gränssnittet inte fryser medan den pågår.
- **`useActionState`** — kopplar ett formulär till en server action och ger tillbaka resultat och väntetillstånd. *Här:* mönstret för i stort sett varje formulär i ABkoll och drilla.
- **Render / re-render** — att komponenten körs och räknar ut hur den ska se ut. Sker om vid varje ändrat tillstånd.
- **`key`** — den stabila identiteten på varje post i en lista, så att React vet vad som är samma sak mellan två renderingar. Aldrig listans index om ordningen kan ändras.
- **Controlled vs uncontrolled** — ett fält vars värde React äger, respektive ett som DOM:en själv håller reda på.
- **Lifting state up** — att flytta tillstånd uppåt till närmaste gemensamma förälder när två komponenter behöver samma data.
- **Prop drilling** — att skicka data genom många mellanliggande lager som inte själva behöver den. Symptom på att något borde ligga i en context eller en store.
- **Context** — ett sätt att göra data tillgänglig långt ned i trädet utan att skicka den led för led.
- **Custom hook** — egen `use`-funktion som samlar återkommande logik. *Här:* `useTableSort`, `useDialogFocus`, `useReplenishmentDraft`.

---

## 15. Next.js och App Router

Ramverket i ABkoll och drilla. Bygger på React, men flyttar en stor del av arbetet till servern.

- **Next.js** — ramverket som ger routing, serverrendering och bygge i ett.
- **App Router** — den nyare routingmodellen där mappstrukturen i `app/` *är* adresserna. Föregångaren heter Pages Router och är en annan värld — sökresultat om den gäller inte här.
- **`page.tsx`** — sidan på en adress. *Här:* 49 stycken i drilla.
- **`layout.tsx`** — ramen runt sidorna under sig. Ritas inte om när man byter undersida.
- **`loading.tsx`** — det som visas medan sidan hämtar sin data.
- **`error.tsx` / `not-found.tsx`** — sidan för när något gick fel respektive för 404.
- **`route.ts`** — en API-endpoint i stället för en sida.
- **`actions.ts`** — filen där server actions bor, enligt konventionen i era repon.
- **Dynamic route** — mappnamn i hakparenteser, `[orgnr]`, som fångar en variabel del av adressen.
- **Server component** — komponent som körs på servern. Får läsa databasen direkt och skickar aldrig sin kod till webbläsaren. Standardläget i App Router.
- **Client component** — komponent som också körs i webbläsaren. Krävs för tillstånd, effekter och allt som reagerar på klick.
- **`"use client"`** — raden överst i filen som gör den till en client component. Allt den importerar dras med. *Här:* 73 filer.
- **`"use server"`** — raden som märker en funktion som körbar på servern från klienten.
- **Server action** — en funktion som ser ut som ett vanligt anrop i klientkoden men körs på servern. Ersätter det mesta av "bygg ett API för formuläret".
- **`revalidatePath` / `revalidateTag`** — beskedet "den här sidans data är inaktuell, hämta om". Det som gör att listan uppdateras efter att du sparat. *Här:* 125 anrop.
- **`redirect()` / `notFound()`** — avbryter renderingen och skickar användaren vidare respektive visar 404.
- **`cookies()` / `headers()`** — läser förfrågans kakor och huvuden på servern. Används för inloggningssessionen.
- **Middleware** — kod som körs före varje förfrågan, innan sidan väljs. *Här:* det som håller Supabase-sessionen vid liv.
- **SSR / SSG / ISR / CSR** — sidan byggs vid varje förfrågan, vid bygget, vid bygget men förnyas i bakgrunden, respektive i webbläsaren.
- **Hydration** — när JavaScript tar över den färdigrenderade HTML:en i webbläsaren och gör den levande.
- **Hydration mismatch** — servern och klienten renderade olika, och React klagar. Klassisk orsak: ett datum eller slumptal som skiljer sig mellan de två.
- **Streaming / Suspense** — att skicka sidan i delar och visa det snabba direkt medan det långsamma laddar klart.
- **Metadata** — Next.js sätt att sätta titel och Open Graph per sida, i kod i stället för i `<head>`.
- **Edge vs Node runtime** — två miljöer koden kan köras i: den lätta och snabba nära användaren, respektive den fullständiga.
- **Astro** — ett annat ramverk för innehållstunga sidor, som skickar noll JavaScript som standard. *Här:* ABkolls marknadssajt i `webb/`.

---

## 16. Databasen — Postgres och Supabase

Ryggraden i alla tre app-repona.

- **Supabase** — plattformen som paketerar en Postgres-databas med inloggning, fillagring, API och serverfunktioner.
- **PostgreSQL (Postgres)** — själva databasen. Allt annat i Supabase är lager runt den.
- **Schema / table / column / row** — namnrymd, tabell, kolumn, rad. `public` är standardschemat.
- **Primary key** — kolumnen som unikt identifierar raden.
- **Foreign key** — en kolumn som pekar på en rad i en annan tabell och som databasen ser till att den faktiskt finns.
- **Index** — sorterad uppslagsstruktur som gör sökningar snabba. **Unique index** hindrar dubbletter; **partial index** täcker bara raderna som matchar ett villkor.
- **Constraint** — regel databasen själv upprätthåller: `not null`, `check`, `unique`.
- **Enum** — en kolumntyp med ett fast antal tillåtna värden.
- **`jsonb`** — kolumn som rymmer godtycklig JSON och går att söka i. Bra för det som inte har fast form; dåligt som ursäkt för att slippa modellera.
- **View / materialized view** — en sparad fråga som beter sig som en tabell, respektive en vars resultat lagras på disk och behöver uppdateras.
- **Function / trigger** — kod som bor i databasen, respektive en funktion som körs automatiskt vid insert, update eller delete.
- **RPC** — att anropa en databasfunktion via API:et i stället för att skriva frågan i applikationen.
- **Transaction** — flera operationer som lyckas eller misslyckas tillsammans. Antingen allt, eller ingenting.
- **Upsert / `on conflict`** — "lägg in raden, eller uppdatera den om den redan finns".
- **Migration** — en numrerad SQL-fil som ändrar databasens struktur. Körs i ordning och aldrig om. *Här:* 79 i drilla, 35 i ABkoll, 10 i Helny.
- **Migreringsnummer** — prefixet som avgör ordningen. Två grenar som råkar ta samma nummer ger en konflikt som inte syns förrän de körs. *Här:* drilla har en egen CI-kontroll, `lint:migreringsnummer`, som vaktar just det.
- **Seed** — data som fylls i en tom databas så att den går att använda lokalt.
- **Baseline** — beskedet att migreringar upp till ett visst nummer redan är körda i en befintlig databas, så att de inte försöker köra igen.
- **RLS (Row Level Security)** — Postgres regel att en rad bara syns för den som har rätt till den. Utan RLS ser vem som helst med API-nyckeln allt. **Kärnan i hela säkerhetsmodellen här.**
- **Policy** — den enskilda regeln under RLS: vem får läsa, lägga till, ändra, ta bort vad. *Här:* 186 stycken över repona.
- **`security definer` vs `security invoker`** — en funktion som kör med sin ägares rättigheter, respektive med anroparens. `definer` är sättet att låta en funktion göra mer än användaren får — och därför det farligaste man skriver.
- **Anon key vs service role key** — den publika nyckeln som lyder RLS, respektive huvudnyckeln som går förbi allt. Service role-nyckeln får aldrig nå webbläsaren.
- **JWT** — den signerade biljetten som bär vem användaren är. Det RLS-reglerna läser för att avgöra vad som får synas.
- **Supabase Auth** — inloggningen: e-post, lösenord, magiska länkar, sessioner.
- **PostgREST** — motorn som gör tabeller och funktioner till ett REST-API. Det `supabase-js` egentligen pratar med.
- **`@supabase/ssr`** — klientbiblioteket som håller sessionen konsekvent mellan server och webbläsare i Next.js.
- **Supabase Vault** — krypterad förvaring av hemligheter *inne i* databasen, så att ett API-token kan användas av en databasfunktion utan att ligga i klartext. *Här:* Kleer-tokenet.
- **`pg_cron`** — schemalagda jobb inuti Postgres. Databasen kör alltså sina egna återkommande uppgifter.
- **`pg_net`** — låter databasen göra HTTP-anrop, t.ex. väcka en Edge Function från ett cron-jobb.
- **Connection string** — hela adressen med användare och lösenord som ett verktyg ansluter med. En hemlighet.
- **N+1** — att hämta en lista och sedan göra ett anrop per post i den. Den vanligaste prestandamissen mot en databas.

---

## 17. Serverlöst — Edge Functions och integrationer

- **Edge Function** — en liten fristående funktion som körs på begäran, utan server att sköta. *Här:* 12 i ABkoll, 17 i Helny, körda på Deno.
- **Endpoint** — en enskild adress ett API svarar på.
- **Serverless / cold start** — modellen utan egen server, och fördröjningen första gången en vilande funktion väcks.
- **Webhook endpoint** — en funktion som *tar emot* anrop när något händer hos någon annan. *Här:* `zettle-webhook`.
- **HMAC-signatur** — kryptografisk stämpel på ett inkommande anrop som bevisar att det kommer från rätt avsändare. Måste kontrolleras, annars kan vem som helst posta till din webhook.
- **Idempotens** — att samma anrop två gånger ger samma resultat som en gång. Nödvändigt eftersom webhooks levereras om vid tveksamhet.
- **Retry / backoff** — att försöka igen vid fel, med växande paus mellan försöken.
- **Rate limit** — takgränsen för hur många anrop ett API tar emot per tidsenhet.
- **Pagination / cursor** — att hämta stora resultat i sidor, där markören pekar på var nästa sida börjar.
- **Polling** — att fråga upprepade gånger om något hänt. Motsatsen till webhook, och sämre när det finns val.
- **OAuth** — inloggningsdansen där en användare ger din app rätt att agera i deras namn hos en annan tjänst, utan att lämna ut sitt lösenord.
- **Access token / refresh token** — den kortlivade nyckeln som används vid anrop, och den långlivade som hämtar en ny när den gått ut.
- **Callback URL** — adressen tjänsten skickar tillbaka användaren till efter godkännandet. Måste registreras i förväg. *Här:* `fortnox-callback`, `instagram-callback`.
- **PKCE** — tillägget till OAuth som gör flödet säkert även när appen inte kan hålla en hemlighet — alltså i mobilen.
- **Client secret** — appens eget lösenord mot tjänsten. Hör hemma på servern, aldrig i appen.
- **Sandbox vs production** — leverantörens testmiljö respektive skarpa miljö. Olika nycklar, olika data.

---

## 18. Mobilappen — Expo och React Native

Helny är byggd så här, och ABkoll har en app i `mobil/`.

- **React Native** — React som ritar riktiga native-komponenter i stället för HTML. Ingen DOM, ingen CSS.
- **Expo** — verktygslådan runt React Native: bygge, uppdateringar, kamera, notiser, allt förpaketerat.
- **Expo Router** — filbaserad routing i appen, samma idé som Next.js App Router.
- **Metro** — Expos bundler.
- **`app.json` / `app.config.js`** — appens identitet och inställningar: namn, ikon, behörigheter, uppdateringar.
- **EAS (Expo Application Services)** — molntjänsten som bygger, uppdaterar och skickar in appen.
- **EAS Build** — bygget som producerar en installerbar app i molnet, så du slipper Xcode och Android Studio.
- **Build profile** — en namngiven byggkonfiguration i `eas.json`. *Här:* `development`, `preview`, `testflight`, `production`.
- **Development build** — en egen app med utvecklarverktygen i, som du installerar en gång och sedan laddar ny kod i.
- **Internal distribution** — att dela ett bygge direkt med testare via länk, förbi butikerna.
- **APK / AAB / IPA** — installationsfilerna: Android direktinstallation, Androids butiksformat, respektive iOS.
- **TestFlight** — Apples kanal för att låta testare köra appen före släpp.
- **Submit** — steget som lämnar in bygget till App Store eller Google Play.
- **OTA (over the air) / EAS Update** — att skicka ut ny JavaScript-kod till redan installerade appar utan nytt butikssläpp. *Här:* beskrivet i `docs/ota.md`.
- **Channel** — kanalen ett bygge lyssnar på för uppdateringar. `production` hör ihop med produktionsbygget, `preview` med testbygget.
- **Runtime version** — versionen av den *native* delen. En OTA-uppdatering når bara appar med samma runtime version — det är gränsen för vad OTA kan bära. Ändras något native måste ett nytt bygge ut.
- **`appVersionSource: remote`** / **`autoIncrement`** — EAS håller reda på byggnumret åt er och räknar upp det automatiskt.
- **Native module** — kod i Swift/Kotlin som JavaScript kan anropa. Så snart en ny sådan tillkommer krävs ett nytt bygge.
- **`Platform.OS`** — kontrollen för när iOS och Android behöver bete sig olika.
- **`StyleSheet.create`** — React Natives motsvarighet till CSS. Ett begränsat urval egenskaper, flexbox som standardlayout.
- **`Pressable`** — det tryckbara elementet. *Här:* 592 användningar i Helny — appens verkliga byggsten.
- **`FlatList`** — listan som bara ritar det som syns. Nödvändig för långa listor.
- **Reanimated / `useSharedValue`** — animationsbiblioteket som kör animationer utanför JavaScript-tråden så att de inte hackar.
- **Safe area** — ytan som inte skyms av hack, hörn och hemknappsindikator.
- **AsyncStorage vs SecureStore** — enkel lokal lagring respektive lagring i telefonens krypterade nyckelknippe. Tokens hör hemma i det senare.
- **Push notification / Expo push token** — aviseringen och den adress som identifierar just den installationen.
- **Deep link** — en länk som öppnar en bestämd plats i appen i stället för webbläsaren.
- **Splash screen** — bilden som visas medan appen startar.
- **Zustand** — det lilla biblioteket för delat tillstånd i Helny. En **store** som komponenter läser bitar ur.

---

## 19. Drift, miljöer och publicering

- **Vercel** — plattformen som hostar Next.js-apparna. Push till `main` publicerar.
- **Region** — var koden körs geografiskt. *Här:* `arn1`, Stockholm — nära både användarna och databasen.
- **Preview deployment** — en egen publicerad kopia per pull request, med egen adress. Så granskar man en ändring på riktigt före merge.
- **Production deployment** — det som ligger på den skarpa adressen.
- **Environment (miljö)** — den avgränsade uppsättningen inställningar och data: utveckling, förhandsvisning, produktion.
- **Environment variable** — värde som matas in utifrån i stället för att stå i koden. `.env.example` visar vilka som behövs, utan att avslöja dem.
- **Secret** — en miljövariabel som är hemlig. Lagras i GitHub eller Vercel, aldrig i repot.
- **Provisioning** — att sätta upp en miljö från grunden. *Här:* Helnys `prod-provision`.
- **Rollback** — att gå tillbaka till föregående version när något gick fel.
- **Health check / watchdog** — ett schemalagt anrop som kontrollerar att systemet svarar och larmar när det inte gör det. *Här:* Helnys `health-watchdog` och `ops-probe`.
- **Backup / restore** — säkerhetskopia och återläsning. En backup som aldrig provats återläsas är en förhoppning, inte en backup.
- **Observability / logg** — att kunna se vad som faktiskt hände i drift.
- **Incident / postmortem** — en driftstörning, och genomgången efteråt av vad som orsakade den.
- **Feature flag** — en strömbrytare som låter kod ligga ute utan att vara påslagen.
- **Docker** — behållartekniken som kör en lokal Postgres på din maskin. *Här:* det ABkolls session-start-hook startar innan migreringarna körs.

---

## 20. Test och automatiska kontroller

- **Vitest** — testramverket i alla tre app-repona.
- **`describe` / `it` / `expect`** — gruppen, det enskilda testfallet, och påståendet som ska stämma. *Här:* över 4 600 `expect` i drilla.
- **Assertion** — själva påståendet i ett test.
- **Mock / spy / stub** — en falsk ersättare för något långsamt eller externt, ett sätt att se att en funktion anropades, respektive ett förenklat svar.
- **Fixture** — förberedd testdata.
- **Unit / integration / end-to-end** — test av en enskild funktion, av flera delar tillsammans, respektive av hela flödet som en användare.
- **Playwright** — verktyget som kör en riktig webbläsare i testet. *Här:* Helnys `ui:shots`, som tar skärmbilder av gränssnittet.
- **Headless** — webbläsare utan fönster, som i CI.
- **Coverage** — hur stor del av koden testerna faktiskt kör igenom.
- **Flaky test** — ett test som ibland faller utan att koden ändrats. Värre än ett trasigt test, eftersom det lär folk att ignorera rött.
- **Regression test** — test som skrivs när en bugg rättas, så att just den buggen inte kan komma tillbaka.
- **Gate** — en kontroll som måste vara grön för att något ska få hända. *Här:* drillas `lint:klientanrop` och `lint:migreringsnummer`, och att `db:queries` provkör databasfrågorna.
- **Grön CI räcker inte** — kontrollerna körs mot en lokal databas. Att en migrering går igenom där betyder inte att den går igenom mot den skarpa. *Här:* uttalat i drillas `docs/automatiska-migreringar.md`.

---

## 21. GitHub Actions i praktiken

Här finns 34 arbetsflöden över repona. Det här är begreppen de är byggda av.

- **Trigger (`on:`)** — vad som startar flödet.
- **`push` / `pull_request`** — starta vid push till en gren respektive när en PR öppnas eller uppdateras.
- **`workflow_dispatch`** — manuell start via *Actions → Run workflow*. Den vanligaste triggern i era repon: 29 av flödena.
- **`schedule` / cron** — starta på klockslag.
- **`workflow_run`** — starta när ett *annat* flöde blivit klart. *Här:* Pinnflytt väntar på att Prov ska bli grönt, i stället för att köra parallellt.
- **Job / step / runner** — flödets delar, och maskinen de körs på (`ubuntu-latest`).
- **`needs`** — beroendet som gör att ett jobb väntar på ett annat.
- **`matrix`** — samma jobb kört flera gånger med olika värden.
- **`concurrency`** — gruppen som ser till att bara ett flöde av samma sort kör i taget.
- **`permissions`** — vad flödets token får göra. Ge så lite som möjligt.
- **`secrets` vs `vars`** — hemliga respektive öppna värden. Hemligheter maskeras i loggen.
- **Action** — ett återanvändbart steg. *Här:* `actions/checkout`, `actions/setup-node`, `expo/expo-github-action`, `supabase/setup-cli`.
- **Pinning av actions** — att låsa en action vid en version (`@v4`) i stället för att följa den rörligt. Samma resonemang som för beroenden: någon annans kod kör med era rättigheter.
- **Artifact (i Actions)** — fil som ett jobb sparar för nedladdning efteråt. Inte samma sak som en publicerad Artifact-sida i Claude Code — samma ord, två system.
- **Fork-risken** — ett publikt repo som kör CI på PR:er från främlingar får inte ge dem tillgång till hemligheterna. *Här:* därför saknar roadmap-repot `pull_request` som trigger på Pinnflytt.

---

## 22. Era egna system och konventioner

Det som inte går att slå upp någon annanstans än här.

- **Roadmap-motorn (`@go-upstream/roadmap`)** — den delade koden som gör en roadmap till en läsbar sida med kort, tabell och kanban. Bor i eget repo så att en förbättring görs en gång och når alla.
- **Motor vs projekt** — motorn känner inte till något projekt; allt projektspecifikt kommer ur `konfig.js` och `data.js`. Det är hela poängen med uppdelningen.
- **`konfig.js` / `data.js` / `tema.css` / `bygge.json`** — projektets egen katalog: regler och faser, posterna, grafisk profil, respektive vilka filer bygget läser och vart det skriver.
- **`konsumenter.json`** — sanningen om vilka repon som hämtar motorn. Står ett projekt inte där nås det aldrig av en pinnflytt.
- **Pinnflytt** — automatiken som öppnar en PR i varje konsument som skriver om commithashen när motorn uppdaterats. Grenen `roadmap/pinnflytt` återanvänds, så två motorcommiter tätt inpå varandra ger en PR och inte två.
- **Artefakt-url:en** — den publicerade roadmap-sidans adress. **Måste återanvändas** vid ombygge; publicerar man utan den skapas en ny sida och den redan delade länken slutar uppdateras. Därför står url:en i pinnflyttens PR.
- **Faser / fasOrdning** — projektets leveranser i ordning, plus tillstånden `levererat` och `uteslutet`. Den första fasen är per definition den som pågår.
- **`CLAUDE.md`** — projektets instruktionsfil till mig. Läses automatiskt vid sessionsstart. Finns i alla fyra kodrepon.
- **`.claude/settings.json`** — vad jag får göra utan att fråga (`allow`) och vad som alltid ska bekräftas (`ask`). *Här:* `git push --force`, `git reset --hard` och att skapa repon ligger under `ask`.
- **`.claude/hooks/session-start.sh`** — skriptet som körs när en session startar: installerar beroenden, städar upp efter Dockers spöken och startar databasen. *Här:* ABkoll.
- **`CLAUDE_CODE_REMOTE`** — miljövariabeln som skiljer en molnsession från din egen laptop. Hooken avbryter direkt om den inte är satt, så att den inte stökar till din maskin.
- **Projektskill** — en egen färdighet i `.claude/skills/`. *Här:* `drilla-design`, som pekar mig på designsystemet innan jag rör gränssnittet.
- **Designsystem** — den samlade sanningen om varumärke, tokens, komponenter och copy. *Här:* drillas `design-system/`, med egna riktlinjer och en efterlevnadskontroll.
- **Svenska namn i koden** — era repon namnger mappar, skript och migreringar på svenska (`bolagsdatum:fyll`, `pafyllningspaminnelser`, `borrbilder`). Konsekvent, och värt att veta innan man letar efter engelska motsvarigheter som inte finns.

---

## 23. Externa tjänster ni integrerar mot

Systemnamn som återkommer i kod och dokumentation.

- **Bolagsverket** — registret över svenska bolag. *Här:* ABkoll hämtar namn, räkenskapsår och kvitton därifrån.
- **Skatteverket** — skattereglerna och underlagen bakom ABkolls beräkningar.
- **Kleer** — lönesystemet ABkoll hämtar löneunderlag ur. Tokenet ligger i Supabase Vault och används bara av Edge-funktionen `kleer-atkomst`.
- **Fortnox** — bokföringssystemet Helny synkar mot, via OAuth med callback.
- **Tradera** — auktionsmarknadsplatsen Helny säljer på och stämmer av priser mot.
- **Zettle** — kassa- och betalsystemet. Skickar webhooks vid försäljning.
- **Instagram Graph API** — Instagram-integrationen, med egen app-granskning innan den släpps.
- **PostNord** — frakten i drilla.
- **Resend** — tjänsten som skickar e-post, inkopplad som SMTP i Supabase.
- **Expo / EAS** — bygg- och uppdateringstjänsten för mobilapparna.
- **Vercel** — hostingen för webbapparna.
- **Personuppgiftsbiträdesavtal (DPA)** — avtalet som krävs med varje leverantör som behandlar personuppgifter åt er. *Här:* Supabase, Vercel och Resend.

---

## 24. Arkitektur och begrepp som återkommer i era genomgångar

- **Datamodell** — hur verkligheten är översatt till tabeller och relationer. Det svåraste att ändra i efterhand.
- **Källa till sanning (source of truth)** — det enda stället ett faktum bor. Två ställen betyder förr eller senare två olika svar.
- **Separation of concerns** — att varje del gör en sak. Skälet till att roadmap-motorn inte känner till något projekt.
- **Coupling / cohesion** — hur hårt delar sitter ihop, respektive hur väl det som hör ihop ligger tillsammans. Målet är löst kopplat och sammanhållet.
- **Abstraktionsnivå** — att koden på ett ställe håller sig på samma detaljnivå. Blandade nivåer är det som gör en funktion svårläst utan att den är komplicerad.
- **Invariant** — något som alltid måste vara sant. Bäst upprätthållet i databasen, sämst i ett dokument.
- **Race condition** — två saker som händer samtidigt och trampar på varandra.
- **Eventual consistency** — att två system får vara osynkade en stund men landar rätt. Vanligt vid webhooks och avstämningar.
- **Avstämning (reconciliation)** — att jämföra två system och rätta skillnaden. *Här:* `reconcile-sales` i Helny.
- **Backfill** — att fylla i historisk data i efterhand när ett nytt fält tillkommit.
- **Kravspec / PRD** — beskrivningen av vad som ska byggas och varför.
- **Beslutsunderlag** — dokumentet som lägger fram alternativen inför ett vägval. *Här:* drilla har fem stycken i `docs/`.
- **Arkitekturgranskning** — den periodiska genomgången av om strukturen fortfarande håller. *Här:* drillas `arkitekturgranskning-2026-08.md` med tillhörande åtgärdsplan.
- **Backlog** — det som är beslutat men inte gjort. **Wishlist** — det som är önskat men inte beslutat. Skillnaden är värd att hålla.

---

*Underhåll gärna listan: stöter du på ett ord som inte står här, lägg till det i
rätt avsnitt så växer ordlistan med projektet.*
