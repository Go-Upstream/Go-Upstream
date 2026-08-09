# Ordlista för utvecklarspråket

En uppslagsbok över de ord, begrepp och system som dyker upp när vi bygger
goupstream.se tillsammans. Termerna står kvar på engelska — det är så de heter i
verktygen och i alla sökresultat — men förklaringarna är på svenska.

Rader markerade **Här:** pekar på var saken faktiskt finns i det här repot.

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
- **GitHub Actions** — GitHub:s inbyggda CI-system. Konfigureras i `.github/workflows/*.yml`. *Här:* inget uppsatt än — sajten är statisk och publiceras direkt.
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

*Underhåll gärna listan: stöter du på ett ord som inte står här, lägg till det i
rätt avsnitt så växer ordlistan med projektet.*
