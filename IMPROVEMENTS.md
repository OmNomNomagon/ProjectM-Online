# riganti.com.au — Modernisation & SEO Checklist

Audit date: 2026-11-13. Site last touched 2022-03-24.

**Status: 16 done, 28 open.** P1 (toolchain) is essentially cleared and the Hugo 0.169
rebuild is live. P0 is the next target — see the two decisions already recorded there.

**Stack:** Hugo + Academia theme (Themefisher fork of Academic), source in
`ProjectM-Online`, built output pushed to `OmNomNomagon.github.io` via the
`public/` git submodule, served by GitHub Pages on `riganti.com.au`.

**Content:** 41 project cards → 36 build write-ups + 14 MK3x docs pages. 245 pages built.

See [DEVELOPING.md](DEVELOPING.md) for how to preview changes locally.

## Priority key

| | Meaning |
|---|---|
| **P0** | Already broken on the live site. Visitors or you are losing something today. |
| **P1** | Not visibly broken, but the toolchain is stuck in 2022 and blocks everything else. |
| **P2** | SEO. Why Google under-ranks the site. The actual goal. |
| **P3** | Speed. Page weight and Core Web Vitals, which also feed into P2. |
| **P4** | New features you asked for. |

Roughly the order to work in — though P1 comes first in practice, since nothing else is
safe to change until the build is modern and previewable.

---

## P0 — Broken right now

- [ ] **Analytics: GA4 is already running — check it before replacing anything.**
      The config sets `googleAnalytics = "UA-158796585-1"`, which is Universal Analytics
      and was switched off on 1 July 2023. **Correction to an earlier note in this file:
      that does NOT mean zero data was collected.** A Lighthouse run on 13 Nov 2026
      shows the legacy `analytics.js` auto-loading a GA4 tag and firing live hits:
      ```
      analytics.js -> /j/collect?tid=UA-158796585-1          dead, discarded
                   -> gtag/js?id=G-K0RETQ1636                GA4 tag, 159 KB
                   -> /g/collect?tid=G-K0RETQ1636&en=page_view   a real GA4 event
      ```
      Google auto-migrated UA properties in 2023 and connected the old tag to a new
      one, so property **G-K0RETQ1636** has likely been collecting since then. Only a
      browser executing the page sees this; it is not in the HTML source, which is why
      the earlier read of the markup missed it.
      **Do this first:** sign in to Google Analytics and look for property
      `G-K0RETQ1636`. If it holds history, that changes the decision below from a
      rescue into a straight preference.
      Then decide: keep GA4, or move to Cloudflare Web Analytics and drop ~180 KB of
      Google JavaScript from every page view.
      **Re "whatever the analytics on checkmate uses":** Checkmate's PageSpeed monitor
      is not analytics. It calls Google's PageSpeed Insights API to run Lighthouse on a
      schedule — synthetic lab tests of *your pages*, with no visitors involved. It
      cannot tell you who came, from where, or what they read. Useful, but it belongs to
      P3, not here.
      **Decided: Cloudflare Web Analytics.** The zone is already proxied through
      Cloudflare (`Server: cloudflare`), and Cloudflare injects the beacon at the edge
      for proxied sites — so this needs **no code change and no redeploy**, just
      enabling the zone in the dashboard. Free, cookieless, no consent banner.
      Checked the live site: **no beacon is present yet**, so it is on `poocorp.com`
      but not this zone. Two things to get right:
      - Do **not** also paste the manual snippet. Cloudflare supports one beacon per
        page; auto-injection plus a manual tag double-counts every visit.
      - **Strip the dead `UA-158796585-1` tag while you are there.** It is still live
        and still fetching `google-analytics.com` on every single page view, costing a
        DNS lookup and a script download to collect precisely nothing.
- [x] **Comments are dead.** Replaced with giscus, see "Comment system". (Was: ReplyBox site `NPOBOrWnVa` returns 404 from
      `app.getreplybox.com`. The service still exists but is now paid-only.
      **Decided: Giscus** ("sounds good"). GitHub Discussions, free, no infrastructure.
- [x] **3 broken project links** in `content/project/*/index.md`:
      - `dining` → `build/dining` (relative, missing leading `/`)
      - `lack` → `build/lack` (relative, missing leading `/`)
      - `speaker` → `/build//speaker` (double slash)
- [x] **Content silently dropped on the Wanhao page.** Hugo warns
      `Raw HTML omitted while rendering content/build/wanhao/index.md`. Goldmark discards
      raw HTML by default, so whatever that block was is missing from the live page.
      Either enable `markup.goldmark.renderer.unsafe` or convert it to Markdown.
      **Decided: convert to Markdown**, not the global `unsafe` flag — scoped to the one
      page rather than loosening rendering sitewide. Show a before/after first.
- [x] **Duplicate `author` key** in `content/project/coffee/index.md` — fatal on modern
      Hugo. Fixed.
- [x] **Broken theme submodule.** `.gitmodules` had no `path` for the theme, so the repo
      would not clone cleanly. Fixed.

## P1 — Toolchain

- [x] **Hugo 0.95.0 (Mar 2022) → 0.169.0.** Theme patched and building clean, 245 pages,
      no errors. Changes: `site.IsServer`→`hugo.IsServer`, `site.Author.*`→`site.Params.*`,
      `site.GoogleAnalytics`/`site.DisqusShortname`→`site.Config.Services.*`, and six
      `path.Base (path.Split .Path).Dir` call sites rewritten to `path.Base .Path` for
      Hugo's new logical-path semantics.
- [x] **Hugo installed properly** via winget (0.169.0 — the same version the upgrade was
      tested against), not a throwaway binary.
- [x] **Local preview pipeline.** `scripts/serve.ps1` (live reload on localhost:1313),
      `scripts/build.ps1` (safe check build into a temp folder), `scripts/build.ps1 -Deploy`
      (real build into `public/`), plus `.claude/launch.json` so the desktop app's Browser
      pane drives the same server.
- [x] **Verified after the upgrade:** homepage, slider, nav and all 41 project cards render;
      Isotope filter buttons still work (All → 41, Woodworking → 12).
- [x] **Fixed: docs sidebar vanished on chapter landing pages.** Hugo 0.146 rewrote
      template lookup, and `layouts/<type>/<section>.html` now outranks
      `layouts/<type>/list.html`. So `section/docs.html` — the template that lists the
      documentation sets — was swallowing `/docs/mk3x/` too, which should use the full
      docs layout. `docs/list.html` was never executing at all (confirmed with
      `hugo --templateMetrics`). Fix: renamed `section/docs.html` → `docs/docs.html`
      (the index), added `docs/chapter.html` (the full layout), and set
      `layout: chapter` on `content/docs/mk3x/_index.md`. Both now resolve explicitly
      rather than relying on lookup precedence, so a future Hugo cannot re-break it.
      **Any new documentation set needs `layout: chapter` in its `_index.md`.**
- [x] **Full page-by-page parity pass, 0.95 vs 0.169.** Compared all 124 pages on
      normalised structure (title, meta description, every heading, every link, every
      image, full visible text). Result: **titles, descriptions, headings and links are
      now 100% identical**; the only remaining text differences are two deliberate fixes
      below. Found and fixed three real regressions:
      - **Pagination silently halved.** `paginate = 20` was replaced by
        `[pagination].pagerSize` in Hugo 0.128 and is now ignored *without any warning*,
        so every list page dropped to Hugo's default of 10 items. Fixed in `config.toml`.
      - **A title was being corrupted.** `content/build/lack/index.md` had a literal TAB
        inside its title (`Wanaho Lack Triple Stack<TAB>3D Printer Enclosure`). The old
        YAML parser treated it as a space; the new one strips it, producing
        "Stack3D Printer Enclosure" in the `<title>`, the `<h1>` and every listing.
      - **`/docs/` regressed while I was fixing `/docs/mk3x/`.** Both section pages
        originally used the full docs layout; my first fix made `/docs/` render a cards
        listing instead. Restored.
- [x] **`--noBuildLock` added to `build.ps1`** — Hugo serialises builds on
      `.hugo_build.lock`, so a check build would hang indefinitely while the preview
      server was running.
- [ ] **Deliberate change to review:** `content/build/sidet/index.md` was the only page
      with no `summary:`, so Hugo auto-generated one — dumping its first ~70 words onto
      every listing, unlike the other 35 cards. Gave it
      `summary: Red Ironbark replacement top`. Say if you'd rather have the long excerpt.
- [x] **36 more files have trailing TABs in front matter** (`content/build/*`,
      `content/project/*`). Harmless today since they get trimmed, but they are how the
      `lack` corruption happened. Worth a cleanup pass.
- [ ] **18 `desktop.ini` files are committed to git and published live** — e.g.
      <https://riganti.com.au/project/dining/desktop.ini> returns HTTP 200. OneDrive
      droppings from before the repo moved to `C:\Git`. Delete and add to `.gitignore`.
- [x] **Deployed to the live site.** First deploy since March 2022. Verified in
      production: all key pages 200, both `riganti.com.au` and `www.`, all 41 renamed
      images resolve, 20 cards per list page, docs sidebars present.
- [x] **`--renderToMemory` on the preview server.** Since Hugo 0.123 `hugo server`
      renders to `public/` *on disk* — the live-site submodule — so previewing was
      filling the deploy repo with pages carrying injected livereload script tags.
      That would have gone straight to production on the next deploy.
- [x] **`CNAME` now generated from `static/`.** It existed only in the deploy repo and
      survived purely because Hugo does not clean its destination. A clean rebuild, or
      anyone running `--cleanDestinationDir`, would have silently dropped the custom
      domain and taken the site offline.
- [x] **Large diff on first deploy** — as expected: Hugo's new processed-image naming
      (`featured_hu<md5>_<bytes>_<dims>_<filter>.jpg` → `featured_hu_<hash>.jpg`)
      renamed all 41 generated images. Content identical; 139 modified, 84 new, 0 deleted.
- [x] **Two upgrade side-effects that are improvements, not regressions:** internal links
      are now consistently trailing-slashed (the old build emitted both `/page1` and
      `/page1/`, costing a redirect), and `+` in URLs is entity-encoded as `&#43;`, which
      browsers decode identically.
- [x] **Committed the theme fixes** to the `Academia-hugo` fork and bumped the submodule
      pointer. Both repos merged fast-forward to `master` and pushed.
- [ ] **Theme folder case mismatch.** Config says `theme = "academia-hugo"`, folder is
      `Academia-hugo`. Works on Windows, will fail on Linux CI. Make them match.
- [ ] **No CI/CD.** Deploys are a manual `public/` submodule commit. Move to a GitHub
      Actions workflow that builds and pushes to the Pages repo on every push to master.
- [x] **Stale `public/` submodule pointer** — the source repo pointed at a Mar 2020 commit
      while the live site ran Mar 2022. Now tracking the deployed build.
- [ ] **Deprecated APIs still in use.** All of these still build today; all will break
      eventually. Surfaced by the new build script:
      - `[blackfriday]` config block — no effect since Hugo 0.60, pure dead weight
      - `imaging.quality` → per-format `imaging.jpeg.quality` etc. (0.163)
      - `languages.en.languageCode` → `locale` (0.158)
      - `.Site.LanguageCode` → `.Site.Language.Locale` (0.158)
      - `.Site.Data` → `hugo.Data` (0.156)
      - `.Page.IsNode` → `.Page.IsBranch` (0.163)
      - `css.Sass` libsass → dartsass (0.153)

## P2 — SEO

- [x] **No structured data at all** (zero JSON-LD on the site). Add `Person` + `WebSite`
      sitewide, `BreadcrumbList` on nested pages, and `HowTo` or `Article` on build pages.
      The build write-ups are step-by-step with photos — strong rich-result candidates.
- [x] **`robots.txt` has no `Sitemap:` line.** It is literally just `User-agent: *`.
- [x] **Multiple `<h1>` per page** — the search box emits one and the hero emits two more.
- [x] **Every project dated 2020-02-19**, minutes `00:22`–`00:59`, because dates were used
      to force display order. Sitemap `lastmod` is therefore meaningless and there is no
      freshness signal anywhere. Fix alongside the sorting work below.
- [~] **`og:image` is `mustangB.jpg` sitewide** (project and docs pages now use their own photo; homepage and tag pages still use mustangB.jpg) — a generic car photo on every share card.
      Use each project's `featured.jpg` per page.
- [ ] **`og:updated_time` frozen at 2020-02-19.**
- [ ] **Thin and orphaned pages, all live and returning 200:**
      - `/authors/` (2 sitemap entries), `/categories/` (1), `/publication_types/` (1) —
        generated but empty. Drop those taxonomies; this site has no publications.
      - `/slides/` and `/details/` — no longer generated by any build, but still served
        because Hugo does not clean its destination. Orphaned since at least 2022.
        Delete them from the deploy repo.
- [x] **Duplicate meta descriptions** — the sitewide description repeats on many pages.
- [x] **Redundant titles** — "Projects | Mark Riganti's Projects".
- [x] **Typos in public titles:** "Wahnao"/"Wanaho" vs "Wanhao", "Regidity" in a card
      description.
- [ ] **The navbar brand is an `<a>` nested inside another `<a>`.** In
      `navbar.html`, `<a class="navbar-img">` wraps `<a class="navbar-brand">`.
      Nested anchors are invalid HTML; browsers silently close the outer one, so
      what ships is not the structure the template describes. Harmless today but
      worth untangling — it is the kind of thing that makes a header link behave
      differently in one parser than another.
- [x] **Navbar brand restyled.** Now "Code · Cad · Carve · Create": the separators in
      `maintitle` are middle dots, wrapped by the template in
      `<span class="brand-sep">`, taking the site blue `#59A5F0` at 1.45em with
      `line-height: 0` so the larger glyph does not grow the navbar. Letter-spacing
      cut from 2.5px to 1.4px.
      Dot alignment is `vertical-align: baseline` with `top: 1px`, derived by
      measuring rather than nudging: in Lato at 23px the cap height is 17px, so the
      capitals' optical centre is 9px above the baseline, while the middle dot's ink
      centre sits 10px above its own. `vertical-align: middle` aligns to half
      x-height instead, which is what made the dot sit visibly low. `.navbar-brand` also had to move from `inline-flex` to
      `inline-block`: in a flex container each run of text is an anonymous flex item
      with its whitespace trimmed, so once the colons were wrapped the spaces around
      them vanished and the brand rendered as "Code:Cad:Carve:Create".

## Hero and navbar — settled values

Kept here because several were derived by measurement, not taste, and would be easy
to undo by accident.

**The root font size is responsive**, which is not obvious and catches you out:

```css
html { font-size: 16px }
@media screen and (min-width: 58em) { html { font-size: 20px } }
```

So `1rem` is 20px above 928px and 16px below it, and every `rem` value here renders
at 80% on a narrow window. Two consequences worth remembering:
- Proportions between `rem`-sized elements hold at both sizes, so the hero title stays
  1.3x the navbar brand either way.
- Anything sized in `px` does NOT scale with them and will drift out of proportion at
  the smaller root. The tagline dots were originally 4px and had to move to `em`.

| | Value | Why |
|---|---|---|
| Navbar brand | 23px, letter-spacing 1.4px | was 2.5px |
| Brand separator | `maintitle = "Code >> Cad >> Carve >> Create"` | the navbar template wraps `>>`, `//` or `·` and applies the matching class, so switching is a config edit |
| — `>>` | inline SVG, `#59A5F0` via `currentColor`. `height: 0.74em` (Lato cap height), `vertical-align: baseline`; double `0.64em` wide (viewBox `0 0 64 74`), single trail chevron `0.28em` (viewBox `0 0 28 74`). Polyline `6.5,2.5 21.5,37 6.5,71.5` (second at x+36), `stroke-width: 13` = 0.13em, bevel join, butt cap. Margins `0.14em` / `0.1em`; trail chevrons `margin-right: 0.12em` | a font glyph can't be made taller and skinnier without its strokes distorting, so it's drawn instead. viewBox units are 0.01em on both axes, so the stroke stays an even 0.13em — the measured stroke of Lato 700's own `>`. Measured at 23px: 17.02px tall vs 17px cap height, 2.99px stroke |
| Brand trail | `brand_trail = 7`, `brand_trail_char = ">"` in config | a decorative run of slashes after the wordmark, fading **0.70 → 0.10**. The endpoints are stated in the template and the step is derived from the count, so changing `brand_trail` still spans the same fade. `aria-hidden`, so it stays out of the link's accessible name — otherwise the link announces as "…Create slash slash slash…". Set to `0` to remove |
| — `//` | `#59A5F0`, weight 700, `letter-spacing: 0.136em`, margins `0.09em` / `-0.046em`, `-webkit-text-stroke: 0.3px`, `inline-block` + `scaleY(0.8)`, `transform-origin: center`, `top: 0.039em` | 80% of natural height with the glyph's ink bottom level with the text's — measured misalignment 0px. **Do not use `transform-origin: bottom` for this**: it anchors to the inline-block's *line* box, which sits ~7px below the text's descender line, so scaling toward it drops the glyph visibly low. Centre lands within 0.89px and the `top` nudge closes the rest. Derived from: 23px Lato band = 23 ascent / 5 descent; "Code" ink = 17 ascent / 0 descent (sits on the baseline); "/" ink = 17 / 1. Outer gaps 2.06px. **`letter-spacing` and `margin-right` are coupled** — the letter-spacing trails the last slash, so the negative margin that cancels it must be re-derived whenever the spacing changes, or the right-hand gap drifts. Transforms need a non-inline display, hence `inline-block`, and because they do not affect layout the tuned gaps are untouched by the scaling. The margins give an equal 2.58px gap either side — the right one is negative because the 0.16em letter-spacing already trails the last slash by 3.68px. The stroke thickens the glyph past 700, which is the heaviest Lato this site loads. Measured by rendering the glyph at 8x and scanning the widest ink run: **2.38px bare, 2.63px at 0.3px, 3.13px at 0.7px** | no vertical correction needed; slashes already span the cap height. Weight **700** specifically: Lato is only loaded at 400 and 700, so the brand's own 500 silently falls back to 400 and 700 is the only real heavier cut available. The lopsided margins cancel the trailing letter-space, which applies after the last character as well as between |
| — `·` (unused) | `#59A5F0`, 1.45em, `line-height: 0`, `vertical-align: baseline`, `top: 1px` | derived: Lato cap height 17px → capitals' optical centre 9px above baseline; the dot's ink centre is 10px above its own, so 1px down. `vertical-align: middle` aligns to half x-height and sits visibly low |
| `.navbar-brand` | `display: inline-block` | as `inline-flex` each text run is an anonymous flex item with its whitespace trimmed, which collapsed "Code · Cad" to "Code·Cad" |
| Hero title | "Mark Riganti's Projects", 30px, weight 300, letter-spacing 3px, uppercase | a `//` here is supported by the template (wrapped, accent-coloured, aria-hidden) but deliberately not used — the slashes live in the banner and tagline instead |
| Hero tagline | 16.4px, sentence case, letter-spacing 0.4px, one line | `max-width: none` so it stays on one line without a hard-coded `ch` guess |
| Title → tagline gap | 9px | |
| Tagline separator | `lead_sep` in `content/home/slider.md`: `"dot"`, `"slash"` or `"chev"` (current) | all styles live in the template, so switching is one word rather than a rewrite |
| Section title `<< My Projects >>` | `title_chevrons = true` in `content/home/projects.md`; span `font-size: 1.15rem` (the brand's) so the shared `svg.chev` rules give the banner's exact chevron (14.71 × 17.02px, 13-unit stroke); lifted `calc((0.72 * 1.5rem - 0.74 * 1.15rem) / 2)` to centre on the caps (2.2px above / 2.28px below). Inner chevron `#1065B8` (dark, like the active "All" button), outer `#59A5F0` (light, like the other filter buttons), both solid. Heading tracking `--title-track: 3px` (theme default 4px); heading `margin-bottom: 1rem` (theme 10px) for space before the quote. Gaps `0.6em` left, `calc(0.6em - var(--title-track))` right (15.29px each). Subtitle: "We do things not because they are easy, / but because we thought they would be easy." split with a Markdown hard break (`\\` + newline in the TOML string); sentence case, `font-size: calc(1rem - 2px)` (18px on desktop; theme 1.1rem), `line-height: 1.5`, via `h1:has(.title-chev) + p`. Theme's end dots hidden via `h1:has(.title-chev)` | matches the banner rather than the heading's own font, by request. Left pair is the right pair mirrored in the SVG points. The right gap subtracts the title's trailing 4px tracking. Each chevron is glued to its word, so on a phone it wraps as `<< MY` / `PROJECTS >>` |
| Section title `<< Contact >>` | `title_chevrons = true` in `content/home/contact.md`; same CSS as My Projects, so identical: 14.71 × 17.02px chevrons, dark inner / light outer, 15.29px gaps, 3px tracking, no end dots, sentence-case 18px subtitle 20px below | chevron markup moved into `partials/title_chev.html` ("left"/"right"), used by both the portfolio and contact widgets. Any other widget can opt in by calling that partial around its `<h1>` text; the styling keys off `.section-heading h1:has(.title-chev)`, so nothing else is needed |
| Banner chevron fade | each single chevron 10% fainter than the one before, left to right: 1, 0.9, 0.8, 0.7, 0.6, 0.5 (floored at 0.1 if more separators are added) | set as an `opacity` attribute per polyline by the navbar template, which splits `maintitle` on `>>` so each chevron knows its position |
| Brand trail | `brand_trail = 0` (off) | the fading chevrons after "Create" were dropped; set a count above 0 to bring them back |
| — `chev` | same SVG `>>` as the navbar, `#59A5F0`, margins `0.24em`; `height: 0.72em`, `width: 0.623em`, `stroke-width: 8` (0.08em) | the tagline is Open Sans (only 400 loaded), not Lato: measured stem 0.081em and cap height 0.72em, so the stroke and height follow that font while the shape stays the banner's. Measured at 16.4px: 11.80px tall vs 11.81px cap, bottom on the baseline |
| — `"dot"` | CSS circles, `0.25em`, `#59A5F0`, `top: -0.25em`, also bracketing the line | drawn, not `·` glyphs, so the crawlable text has no punctuation at all; `em` so they track the responsive root |
| — `"slash"` | literal `//`, `#59A5F0`, `letter-spacing: -0.06em` | between items only — a leading `//` reads as a commented-out line. Does put `//` into the crawlable text, unlike the dots |
| Slide tint | `overlay_filter = 0.6` | worst-case contrast 5.8:1 against white; 0.55 gave 4.8:1 |
| CTA | "Explore", `aria-label="Explore projects"`, `.page-scroll` | matches the filter buttons: `#59A5F0`, weight 400, normal tracking, 18px, `#1065B8` on hover via `:focus-visible` |

## P3 — Performance / Core Web Vitals

- [ ] **Cloudflare never caches your HTML.** Every page returns
      `cf-cache-status: DYNAMIC`, meaning it was not even considered cacheable, so all
      2.51k requests/day round-trip to GitHub Pages. Cloudflare caches by file
      extension by default, and every page on this site is an extensionless directory
      URL (`/build/dining/`). Images and CSS do cache once warm — watched one image go
      `MISS` → `HIT` — which is why the dashboard reads only **7.76% cached**: the
      misses are the HTML, plus cold caches at each location on a low-traffic site.
      Fix: a Cache Rule matching `riganti.com.au/*` with *Eligible for cache* and an
      Edge TTL. The site is fully static, so this is safe. Purge on deploy, or keep the
      TTL short — worth wiring into the CI job when that lands.
- [ ] **Get a Core Web Vitals baseline before touching anything.** You already run
      Checkmate at <https://check.poocorp.com> and it has a PageSpeed monitor, which is
      exactly the right instrument for this section. It needs a Google PageSpeed Insights
      API key (free: Cloud Console → enable *PageSpeed Insights API* → Credentials →
      create API key → restrict it to that one API, and set **no** HTTP-referrer or IP
      restriction, which would break a server-side caller like Checkmate). Then point a
      monitor at `riganti.com.au` and let it run before the image work, so the before and
      after are measured rather than assumed.
      **The key is mandatory, not just advisable.** Calling the API without one returns
      HTTP 429 with `"quota_limit_value": "0"` — Google has set the anonymous daily
      quota to zero, so there is no keyless fallback left.
      **Done 13 Nov 2026: key created and saved in Checkmate Settings → Integrations.**
      Note the Cloud Console's "Create credentials → Help me choose" wizard cannot make
      an API key — it only offers an OAuth client or a service account. Go to
      <https://console.cloud.google.com/apis/credentials> and use the
      **+ CREATE CREDENTIALS** menu → *API key* directly.
      Monitors created 13 Nov 2026: "Riganti Projects" and "PooCorp", both initializing.
      Remaining:
      - Confirm the key is restricted to the PageSpeed Insights API, with no
        referrer/IP restriction.
      - **Add a Mobile monitor.** Both monitors were created with the Desktop strategy.
        Google has indexed mobile-first since 2023 and the Core Web Vitals it ranks on
        come from mobile field data, so a Desktop-only baseline measures something
        Google largely does not use — and flatters the site, because a 5.19 MB page
        hurts far more on a phone than on a desktop connection. Keep Desktop if useful,
        but Mobile is the number that matters for the SEO work in P2.
- [ ] **102 MB of images, 411 JPEGs, zero WebP/AVIF.**
      **MOBILE BASELINE — Lighthouse 13.6.0 via PageSpeed Insights, 13 Nov 2026:**
      ```
      Performance score         61 / 100
      Largest Contentful Paint  14.6 s     score 0.00   <-- the whole problem
      Time to Interactive       15.0 s     score 0.07
      Speed Index                6.1 s     score 0.45
      Total Blocking Time        300 ms    score 0.79
      First Contentful Paint     2.1 s     score 0.80
      Cumulative Layout Shift    0         score 1.00
      Total payload             5,800 KiB
      ```
      Google's threshold for "good" LCP is 2.5 s. At 14.6 s this is roughly six times
      over, and LCP is the single heaviest Core Web Vitals ranking input — so this one
      metric is most of why the site under-performs in search.
      Lighthouse's five heaviest resources are the five slider images, nothing else
      close: 756 + 644 + 587 + 555 + 470 KB = **2.94 MB above the fold**. The sixth is
      159 KB of Google Analytics JavaScript.
      Also independently measured by hand: 5.19 MB across 50 assets, which corroborates
      Lighthouse's 5,800 KiB.
      Re-run the same PageSpeed call after the image work to prove the gain.

      **RE-RUN after the first deploy (8458bfd), mobile, Lighthouse 13.6.0, 14 Nov 2026:**
      ```
                                baseline    now       change
      Performance score           61         72        +11
      Largest Contentful Paint    14.6 s     6.1 s     -8.5 s (2.4x faster)
      Time to Interactive         15.0 s     6.4 s     -8.6 s
      Speed Index                  6.1 s     5.3 s     -0.8 s
      Total Blocking Time          300 ms    50 ms     -250 ms
      First Contentful Paint       2.1 s     2.1 s      same
      Cumulative Layout Shift      0         0.012      still "good" (< 0.1)
      Total payload               5,800 KiB  2,912 KiB  -50%
      ```
      The hero image is no longer the problem: it is a 120 KiB AVIF, down from 756 KB.
      LCP is still "poor" (> 4 s) because of what happens *around* the image:
      - LCP phases: first byte 173 ms, load delay 857 ms, image download 1,434 ms,
        then ~3.6 s of **render delay**: the image has arrived but can't paint yet.
      - **Render-blocking CSS** (est. 1.2 s): seven stylesheets load before anything
        paints: the theme's two, Font Awesome, highlight.js, fancybox, academicons,
        Google Fonts. Most aren't needed for the first screen (highlight.js and fancybox
        only matter on build pages; academicons not at all).
      - **Cache lifetimes** (est. 1,645 KiB on repeat visits): GitHub Pages serves
        everything with a 4-hour cache (`max-age=14400`), even fingerprinted files that
        never change. A Cloudflare cache rule can raise that for `/img/`, `/css/`, `/js/`.
      - Heaviest single file is now Google's gtag.js (159 KiB), above the hero image.
      - Image delivery (est. 432 KiB): the project card thumbnails are JPEG and could be
        WebP/AVIF like the hero; the "no explicit width/height" flag is the same cards.
      Next steps, in order of likely LCP gain: drop or defer the non-critical
      stylesheets, then the Cloudflare cache rule, then card thumbnails.

      **Done locally, 14 Nov 2026 (not yet deployed or re-measured):**
      - [x] **Render-blocking: 7 stylesheets → 1.** Audit of what each was for:
        | Stylesheet | Purpose | Used? | Now |
        |---|---|---|---|
        | academicons | academic profile icons | no | removed |
        | highlight.js (+JS) | code colouring | no code anywhere | `highlight = false`; pages opt in with `highlight: true` |
        | fancybox (+JS) | click-to-enlarge lightbox | only `figure`/`gallery` shortcodes, used nowhere | loaded only on pages with those shortcodes |
        | Google Fonts | Lato, Open Sans, Roboto Mono | Roboto Mono = code only | Roboto Mono dropped; loads non-blocking (`display=swap`) |
        | Font Awesome 7 | icons | yes | loads non-blocking (`media="print"` → `all`), preconnect |
        | academia.min.css + academia.css | theme + custom.css | yes | concatenated into one fingerprinted `site.min.css` (177 KiB) |
      - [x] **Card thumbnails:** `<picture>` AVIF q55 → WebP q72 → JPEG q78 at
        480/720/1000w, `sizes` matching the 1/2/3-column grid, explicit width/height
        (fixes the CLS audit), `loading="lazy" decoding="async"`. TV card: 55 KiB JPEG →
        12.5 KiB AVIF. `height:auto` added in custom.css so the attributes don't distort.
      - [ ] **Cloudflare cache rules (you, in the dashboard):** see "Cache rules" below.

      **RE-RUN after deploy 156081c (stylesheets, thumbnails, SEO pass), mobile, 14 Nov 2026:**
      ```
                                baseline   deploy 1   now
      Performance                 61         72        79
      Largest Contentful Paint    14.6 s     6.1 s     4.9 s
      First Contentful Paint      2.1 s      2.1 s     1.3 s   <- the blocking-CSS fix
      Speed Index                 6.1 s      5.3 s     4.4 s
      Total Blocking Time         300 ms     50 ms     50 ms
      Cumulative Layout Shift     0          0.012     0.012
      Total payload               5,800 KiB  2,912 KiB 2,059 KiB
      SEO / Accessibility / Best practices: 92 / 85 / 100
      ```
      Still flagged: LCP and Speed Index; low-contrast text; heading levels skip;
      images without `alt`; links without a discernible name (likely the icon-only
      links: dark toggle has a label, so the footer/author social icons and the
      slider arrows are the suspects).
      **Slider rebuilt 13 Nov 2026 — measured on a fresh local load at phone width:**
      ```
      slider bytes above the fold   2,940 KB  ->  119 KB   (-96%)
      slider files on first load           5  ->      1
      whole page                    5,800 KB  ->  2,872 KB (-50%)
      ```
      What changed: masters moved to `assets/img/slider/` so Hugo can process them;
      slides became real `<img>` in a `<picture>` (AVIF -> WebP -> JPEG) at 1280/1920/
      2560, skipping any width the master cannot supply; slide 0 is
      `eager`/`fetchpriority=high`/`decoding=sync`, slides 1-4 are `lazy`; the caption
      is now static markup outside the carousel, which also cut the homepage from 5
      empty `<h1>` elements to 1 real one.
      The remaining 2,872 KB is mostly the 41 project thumbnails below the fold, which
      are still eager — that is the lazy-loading item below, not the slider.
      Hero styling kept to the original treatment (plain uppercase, light weight, wide
      tracking) after review; the only visible change is that the caption no longer
      slides with the photos. Final sizes: title 30px uppercase, strapline 14px in
      sentence case on a single line. Note the root font size here is **20px**, not
      the usual 16px, so 1rem = 20px when editing these.
      No text-shadow on the caption, matching the original treatment. Checked rather
      than assumed: sampling each slide's pixels behind the caption and compositing
      the tint gives, at the single brightest pixel in that band, 4.8-5.8:1 at the
      original `overlay_filter = 0.55` and 5.8-6.9:1 after raising it to 0.60.
      WCAG AA wants 4.5:1 for normal text and 3:1 for large, so 0.55 already passed;
      0.60 buys roughly a full point of headroom, which matters most for the 16px
      strapline rather than the 30px title.
      Any new slide photo should be checked the same way — a bright, low-contrast
      image could fall below that without the shadow as a safety net.
      The button reads "Explore" rather than repeating the word already in the `h1`,
      and carries `aria-label="Explore projects"` so it is not announced as a bare
      "Explore, link" to anyone using a screen reader. It is styled to match the
      project filter buttons below it exactly — same `#59A5F0`, 400 weight, normal
      tracking, 18px — and darkens to `#1065B8` on hover, the same as those buttons.
      The darkening uses `:focus-visible`, not `:focus`: clicking an anchor focuses
      it and the scroll handler calls `preventDefault`, so a plain `:focus` rule left
      the button stuck dark after every click. `:focus-visible` matches keyboard
      focus only, so keyboard users keep the indicator and mouse users do not.
      The earlier mismatch was never the colour (both were already `#59A5F0`); it
      was the 550 weight and 1.1px tracking inherited from the old hero rule.
      Strapline is `hero_lead_items`, an array rendered as real text with decorative
      blue dashes of equal width between the phrases and at each end. The dashes are
      empty `<span>` elements drawn with a CSS background, not dash glyphs, so their
      lengths are exact rather than at the mercy of the font's en/em dash metrics.
      All carry `aria-hidden="true"`.
      This is slightly BETTER for search than the original comma version: the
      crawlable text now contains no punctuation at all, just
      "Woodworking 3D design Electronics Audio Code builds from the Gong".
      Real spaces sit between the phrases in the markup, so the words never run
      together for a text extractor.
      One SEO caveat: "the Gong" is local slang that almost
      nobody outside the Illawarra will type into a search box. The word people
      actually search is "Wollongong", which currently appears only in the contact
      widget. Worth getting it into this line or a nearby heading.
      The hero button now carries `page-scroll`, which opts it into the theme's own
      1500 ms easeInOutExpo scroll in `academia.js` (`$('nav a, .page-scroll')`).
      Previously only navbar links animated and the hero button jumped instantly.
      Caption layout: the button is anchored to the slider's midline and the heading
      sits above it, rather than the pair being centred as one block.
- [x] **Regression fixed: the slider rewrite blanked every project page.** Each of the
      37 `content/build/*/` bundles carries its own `slider.md`, referencing 164 images
      under `static/img/project/`. `resources.Get` only reads `assets/`, so it returned
      nil for all of them and the `{{ if $master }}` guard skipped the image silently —
      leaving five empty black slides on every project page. Two fixes:
      - The template now falls back to the unprocessed `static/` copy when an image is
        not in `assets/`, and emits a `warnf`. A missing asset should degrade to an
        unoptimised image, never to a blank carousel.
      - All 164 images copied into `assets/img/project/` so they get the same
        treatment as the hero.
      `image_widths` is now a per-slider front matter option. Project sliders default
      to two widths; only the homepage hero opts into 2560, because each extra width
      multiplies the encode work across 164 images.
- [ ] **Slider: deferred slides flash black on first transition.** Confirmed visible,
      not just theoretical — slides 1-4 are `loading="lazy"`, so the first time each
      one appears the browser has not fetched it yet and the slide's
      `background-color` (#333) shows for a beat before the photo lands.
      Fix without touching the critical path: after `window.load`, quietly fetch the
      next slide's image (`new Image().src = ...`, or flip `loading` to `eager` once
      the page has settled). LCP is measured well before that, so slide 0 is
      unaffected. Deliberately left for now so the measured 119 KB first load stands.
      LCP is not re-measured yet: PageSpeed cannot reach localhost, so that needs a
      deploy first.
      **Note CLS is already 0**, so the `width`/`height` item below is about robustness,
      not a problem visible today.
      The slider alone is **2.9 MB above the fold**, in five background images that are
      never seen at full size:
      `shuffle-small.jpg` 755 KB · `PlantDog.jpg` 643 KB · `blur-small.jpg` 586 KB ·
      `shuttle-small.jpg` 554 KB · `mustangB.jpg` 469 KB.
      (Correction to an earlier note in this file: the 4.2 MB `shuffle.JPG` is **not**
      served on the homepage — the slider uses the `-small` variants. Those "small"
      files are still 0.5–0.8 MB each, so the slider is the top target either way, just
      for a different reason. The three multi-MB originals sit unused in `static/`.)
      The 41 project thumbnails below the fold are fine by comparison, ~70 KB each.
- [ ] **No lazy loading anywhere** (0 of 18 images on a sample build page).
- [ ] **No `srcset`.** Images live in `static/`, which bypasses Hugo's image pipeline
      entirely. Moving them into page bundles enables automatic resizing + WebP/AVIF.
- [ ] **No `width`/`height` on images** → cumulative layout shift.
- [ ] **Render-blocking CDN assets, all ancient:** FontAwesome 5.6 (2018),
      academicons 1.8.6, fancybox 3.2.5, jQuery. Self-host and subset, or drop.

## P4 — Features

- [x] **Project sorting** — see below.
- [x] **Comment system** — see below.
- [ ] **Add projects completed since 2022.**

---

## Project sorting

Currently `portfolio.html` does `range where site.RegularPages "Type" "project"`.
Hugo's default order is **weight → date (desc) → title**, and since no project has a
`weight`, order falls through to date — which is why you incremented the minutes.

1. [x] `weight:` added to all 41 projects (200, 250, … 2200, gaps of 50 so new projects
   can slot in between, and below 200 is free for anything that should lead)
   reproducing the old order exactly. `date` no longer drives order.
2. [x] `date:` set to one week apart in the default order, by your choice: oldest
   (Shadow Space, weight 2200) on the original 2020-02-19, each project 7 days after the
   one below it, newest (ReDuplicator, weight 200) on 2020-11-25. All 41 unique.
   Real dates were not recoverable: the photos have no EXIF capture dates (stripped),
   and git first saw 37 of the 41 projects on the same day (2020-02-20).
   Since these dates follow the default order, Newest currently matches Default. They
   diverge once new projects (dated 2022+) are added, which land at the top of Newest
   but wherever their `weight` puts them in Default.
3. [x] Sort control: a plain native `<select>` ("Sort by: Default / Newest / Type"),
   right-aligned just above the grid, not button coloured, so the filters stay the
   primary control. White, 1px `#d9d9d9` border, square corners like the cards, grey
   label; the arrow is the site chevron turned down in `#59A5F0`. Hover border `#59A5F0`,
   keyboard focus `#1065B8` with a soft ring. 26.4px below the filters (theme list margin
   20px → 22.4px, +10%), 12px above the cards (`.project-toolbar:has(.project-sort)
   { margin-bottom: 12px }`, theme 40px). Quote → buttons 45px (was 60px, −25%): the
   heading block's margin 40px → 25px via `.section-heading:has(.title-chev)`.
   Masonry packs whole columns, so the cards stop short of the container (57px at 2000px);
   the script pads the dropdown's row by that shortfall, using Isotope's target positions
   (not on-screen rects, which are mid-animation), on every layout, on any size change
   of the row (ResizeObserver) and on window load. Verified flush at 1400px and 2000px,
   after every filter and every sort.
   Cards 15% larger at their cap: `.wg-portfolio .container { max-width: 1700px }`
   (theme 1500px) → 502px cards, from 437px. Other sections keep 1500px.
   Client-side Isotope `sortBy`, works together with the filters. Keys live on each card
   (`data-date` = Unix seconds, `data-type` = first tag); Type ranks by the filter-button
   order (wood → 3d → audio → electro → dev). Ties fall back to the default order, so each
   group stays curated. A select value restored by back/forward navigation is applied on
   load. `.project-filters .btn { margin-bottom: 4px }` keeps the filter rows apart when
   they wrap on phones.
   Superseded along the way: a three-button row, then a cycling button in the filter row.

## Upstream theme review (2026-11-13)

Compared our fork with the 87 commits on themefisher/Academia-hugo since the Feb 2020
fork point (`upstream` remote added locally). Most are README/demo/hosting; the Hugo
deprecation fixes were already covered by our 0.169 upgrade. Brought across:

- [x] **Footer alignment** (4824e35), applied by hand since our footer has a privacy
  link: `row align-items-center`, `mb-4 mb-md-0` on the left column, `mb-0` on the text
  and icon list. Text and icons now centre to 0px.
- [x] **`expand` shortcode** (72261f0), rebuilt on native `<details>/<summary>`: works
  without JS and with keyboard/screen readers, and renders the inner Markdown
  (upstream's `safeHTML` printed it raw). Usage: `{{< expand "Title" >}} … {{< /expand >}}`.
  Chevron marker that rotates on open; dark-mode colours included.
- [x] **Font Awesome 5.6.0 → 7.0.1** (0b29cde) in the theme's `data/assets.toml`; SRI
  verified against the CDN file. All 24 icons the site uses checked present in v7.
- [x] **Dark-mode styles** (869a058) applied to `_dark.scss` / `_nav.scss`.
- Skipped: MS Clarity (tracking; Cloudflare Web Analytics planned), "dropdown menu"
  (only a quoting change), docs/author/publication fixes (unused pages).

## Dark mode (system-aware)

- [x] `day_night = true`: moon/sun toggle in the navbar.
- No saved choice → follows the OS `prefers-color-scheme`, live (switches without a
  reload when the OS does, e.g. sunset). The toggle saves an override in
  `localStorage.dark_mode` ('1'/'0'); toggling back to what the OS says clears it, so
  the site returns to following the OS.
- Inline script right after `<body>` (baseof.html) applies the mode before first paint:
  no white flash. Also sets `color-scheme` so scrollbars and form controls match.
- Toggle is `role="button"` with `aria-pressed` and a "Switch to dark/light mode" label.
- Fixed a theme bug this exposed: the navbar smooth-scroll handler threw on `href="#"`
  (`$('[name=]')`), which silently cancelled the toggle's own click handler.
- Our elements in dark: headings `#e9ecef` (13:1), quote `#a9adb5` (6.9:1), card titles
  `#f1f3f5` (10.3:1) and text `#b8bcc4` (6:1), sort dropdown `#2d303c` with `#4a4f60`
  border, Send button outlined `#59A5F0`. Heading chevrons swap emphasis in dark: inner
  `#59A5F0` (5.9:1), outer `#1065B8`, since the dark blue almost vanishes up close.

## Section scroll landing

- [x] Nav links, the Explore button and `/#section` URLs used to stop at the section's
  top edge, leaving its 110px top padding as an empty band under the navbar. Now, when
  the target has a `.section-heading h1`, the scroll stops with that heading
  `SECTION_HEADING_GAP` = 46px below the navbar (`anchorScrollTop()` in academia.js,
  used by both the click handler and `scrollToAnchor`). Measured at 1766px: heading
  46px under the navbar, filters at 272px (was 110px / 336px). Other anchors
  (footnotes, docs headings) keep the old behaviour. Contact sits at the page bottom,
  so it stops where the page ends. Navbar highlight verified correct for each.

## Comment system

ReplyBox is alive but your site key is gone and it is now paid-only. Options:

| Option | Cost | Backend | Login required | Notes |
|---|---|---|---|---|
| **Giscus** | Free | GitHub Discussions | GitHub | Recommended. Zero infra, threading, reactions, moderate from GitHub. |
| Utterances | Free | GitHub Issues | GitHub | Older, fewer features than Giscus. |
| Remark42 | Hosting cost | Self-hosted | Anonymous OK | Needs a server you maintain. |
| Isso | Hosting cost | Self-hosted | Anonymous OK | Same. |
| ReplyBox | Paid | Hosted | Google | Revive the old account. |
| ~~Cusdis~~ | — | — | — | **Repo archived July 2026 — do not use.** |

**Status (2026-11-13): working locally.** Discussions enabled on
OmNomNomagon.github.io, "Comments" category (Announcement format) created, giscus app
installed. `repo_id = MDEwOlJlcG9zaXRvcnkyMDU2MTM5OTc=`,
`category_id = DIC_kwDODEFrrc4DLCyO` (read from giscus.app's categories API). On
`/build/tv/` the iframe loads for term `build/tv/`, sizes itself, and giscus's API
answers "Discussion not found" for it, which is the normal empty state: the thread
is created on the first comment. Not yet deployed.

- [x] `partials/comments_giscus.html` replaces the two `<div id="replybox">` hooks
  (project pages via `widget_page/single.html`, docs via `docs_layout.html`). ReplyBox
  script removed from `baseof.html`, `replybox` key removed from config.toml.
- [x] Config under `[giscus]` in params.toml: repo `OmNomNomagon/OmNomNomagon.github.io`
  (the Pages repo, which has to stay public anyway), category "Comments", mapping by URL
  path (strict), reactions on, comment box above the thread, lazy-loaded. Nothing
  renders until `repo_id` and `category_id` are filled in. `comments: false` in a page's
  front matter hides it on that page.
- [x] Follows day/night: starts in `light` or `dark_dimmed` to match the page, and the
  toggle re-themes the iframe live via giscus's `setConfig` message.
- [x] Tested with placeholder IDs: box renders on `/build/tv/`, iframe gets the right
  repo, mapping and theme in both modes, no console errors; then reverted to empty.
- [x] Done by you: (1) repo Settings → Features → tick Discussions; (2) create a
  Discussions category "Comments" of type **Announcement** (only you and giscus can
  open threads); (3) install https://github.com/apps/giscus on that repo only;
  (4) then I read `repo_id` / `category_id` from giscus.app and fill them in.

**Styling (matched to the site, approved 2026-11-14):** custom giscus themes in
`assets/css/giscus-light.css` and `giscus-dark.css` (`theme_light` / `theme_dark` =
`"css/giscus-*.css"` in `[giscus]`). Each is self-contained: giscus's own light /
dark_dimmed base theme copied in, then overrides: transparent canvas, site text greys
and borders, links `#1065B8` light / `#59A5F0` dark, Comment button `#59A5F0` →
`#1065B8`, Open Sans, square corners (avatars round); comment cards and the comment
box styled like the project cards (1px `rgba(0,0,0,.125)` border, `0 2.5px 5px
rgba(0,0,0,.075)` shadow, white / `#343a40` background), replacing giscus's blue
"info" outline; selected Oldest/Newest filled `#59A5F0` with white text; 1px side
padding so the half-pixel frame position can't clip right borders. Page-level
reactions block off (`reactions = false`).

How the theme reaches giscus (it loads it from inside its own iframe, so the
site's CSS can't reach in):
- **Live:** `resources.Get` publishes the file, giscus gets
  `https://riganti.com.au/css/giscus-*.css` (host sends `access-control-allow-origin: *`).
- **Local preview:** the partial passes the file's contents as a `data:text/css;base64`
  URL. A localhost URL cannot work: Chrome/Edge block a public site's frame
  (giscus.app) from fetching localhost (local-network access), so the box rendered
  bare. Going through `assets/` + `resources.Get` makes Hugo track the file, so edits
  show on refresh (when it was read with `readFile` from `static/`, Hugo never
  rebuilt the pages and kept serving a stale copy).
- Debugging lesson: my browser tools can't see inside the iframe; only the visible
  page could confirm the look. `/build/tv/` vs `/build/es10/` differed only because
  es10 has a thread (comment list) and tv didn't.

## Project page pager

- [x] Previous on the left, Next on the right, on one line (`section_pager.html` +
  `.post-nav` flex in custom.css). Each side max half width, so long titles wrap in
  their own column (checked at 375px, no sideways scroll); Next stays right-aligned
  when there is no Previous. The docs section's reversed labels are preserved by
  deciding left/right first: links and labels unchanged from before (checked on
  `/build/desk/`, `/build/tv/`, `/docs/mk3x/page3/`). Now a `<nav aria-label>`.

**Recommendation: Giscus.** Free, no infrastructure, and your audience is makers and
3D-printing people who overwhelmingly already have GitHub accounts. The swap is small:
the theme already has a `<div id="replybox">` hook in `baseof.html`, `widget_page/single.html`
and `docs_layout.html` — replace the embed script and keep the markup.

If anonymous commenting matters more than zero maintenance, Remark42 is the pick instead.

---

## Repo locations

```
C:\Git\ProjectM-Online\              source (Hugo)
C:\Git\ProjectM-Online\public\       submodule → OmNomNomagon.github.io (live site)
C:\Git\ProjectM-Online\themes\Academia-hugo\   submodule → your theme fork
```

Moved out of OneDrive deliberately — OneDrive sync and git working trees conflict.

## Cache rules (Cloudflare)

GitHub Pages sends every file with `Cache-Control: max-age=14400` (4 h). Hugo
fingerprints its processed files (the hash in the name changes whenever the content
does), so those are safe to cache for a year; a deploy produces new names rather
than changing old ones. Plain files under `/img/` (originals) and the giscus theme
CSS are not fingerprinted, so they get a shorter lifetime.

Cloudflare dashboard → riganti.com.au → **Caching → Cache Rules → Create rule**:

1. **"Fingerprinted assets — 1 year"**
   - Custom filter expression (Edit expression):
     `(http.request.uri.path contains "_hu_") or (starts_with(http.request.uri.path, "/css/site.min.")) or (starts_with(http.request.uri.path, "/js/academia.min."))`
   - Cache eligibility: **Eligible for cache**
   - Edge TTL: **Ignore cache-control header and use this TTL → 1 month**
   - Browser TTL: **Override origin → 1 year**
2. **"Other static images — 1 week"**
   - Expression: `(starts_with(http.request.uri.path, "/img/")) or (starts_with(http.request.uri.path, "/project/"))`
     (rule 1 sits above it, so fingerprinted files still get a year)
   - Eligible for cache; Edge TTL 1 week; Browser TTL override **1 week**

Leave HTML alone (it already passes through uncached), so deploys show instantly.
Check afterwards: `curl -sI https://riganti.com.au/<a _hu_ image>` should show
`cache-control: max-age=31536000` and `cf-cache-status: HIT` on the second request.

## SEO and content batch (2026-11-14)

- **Broken links:** `dining` and `lack` cards lacked the leading `/` (worked only from
  the homepage), `speaker` had `//`. All card `external_link`s now end in `/` too, so
  clicks no longer take an extra redirect hop.
- **Wanhao page:** the `<h2>Update June 2017</h2>` that Hugo dropped is now a Markdown
  heading; "Build Of materials" made a heading; typos fixed. The raw-HTML build warning
  is gone (8 → 7 warnings).
- **Typos:** Wahnao/Wanaho → Wanhao, Regidity → rigidity, instuctions → instructions,
  "Mark riganti" → "Mark Riganti", Headbed → Heatbed, es10 description rewritten. Trailing
  tabs/spaces stripped from front matter in 76 files (they leaked into titles).
- **Duplicate pages:** every project existed twice (`/build/x/` write-up and
  `/project/x/` grid card, same title and description). Cards now render as redirects
  (`layouts/project/redirect.html`, via cascade in `content/project/_index.md`):
  canonical + noindex + instant redirect to the write-up, and out of the sitemap. Old
  `/project/x/` links still work. `/project/` redirects to `/#projects`. Tag pages list
  each project once, linking to the write-up (`_default/list.html` filters out cards).
- **One h1 per page:** search box title and all section-widget headings are `h2` now
  (styles moved from `.section-heading h1` to `h2`, search title kept at 2.25rem);
  homepage h1 = hero title, other pages h1 = page title. Checked computed styles match.
- **robots.txt:** `layouts/robots.txt` adds `Sitemap: https://riganti.com.au/sitemap.xml`.
- **Titles:** "<page> | Mark Riganti" (was "| Mark Riganti's Projects"); homepage
  unchanged. `site.Params.title_suffix` overrides.
- **Descriptions:** tag pages get their own instead of the sitewide one.
- **Share images:** project write-ups and MK3x docs use their grid card's photo,
  cropped 1200×630; `og:type` added (article / website).
- **Structured data:** `partials/jsonld.html` — Person (sameAs from contact_links) +
  WebSite on every page, Article on write-ups and docs pages (headline, image, dates,
  tags). Validated as JSON on home, a build page, a docs page and a tag page.
- **Dates:** write-up pages now carry their card's date (they still had the 2020-02-19
  placeholders); Previous/Next neighbours unchanged.
- Noted, not changed: `/privacy/` 404s because `content/privacy.md` is an empty draft
  from the theme template; the footer only links it once published.
