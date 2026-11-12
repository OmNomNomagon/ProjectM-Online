# riganti.com.au — Modernisation & SEO Checklist

Audit date: 2026-11-13. Site last touched 2022-03-24.

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

- [ ] **Google Analytics is dead.** `UA-158796585-1` is Universal Analytics, switched
      off 1 July 2023. You have collected zero data for ~3.5 years. Replace with GA4,
      or a lighter option (Plausible / Umami / Cloudflare Web Analytics).
- [ ] **Comments are dead.** ReplyBox site `NPOBOrWnVa` returns 404 from
      `app.getreplybox.com`. The service still exists but is now paid-only.
      See "Comment system" below for replacement options.
- [ ] **3 broken project links** in `content/project/*/index.md`:
      - `dining` → `build/dining` (relative, missing leading `/`)
      - `lack` → `build/lack` (relative, missing leading `/`)
      - `speaker` → `/build//speaker` (double slash)
- [ ] **Content silently dropped on the Wanhao page.** Hugo warns
      `Raw HTML omitted while rendering content/build/wanhao/index.md`. Goldmark discards
      raw HTML by default, so whatever that block was is missing from the live page.
      Either enable `markup.goldmark.renderer.unsafe` or convert it to Markdown.
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
- [ ] **36 more files have trailing TABs in front matter** (`content/build/*`,
      `content/project/*`). Harmless today since they get trimmed, but they are how the
      `lack` corruption happened. Worth a cleanup pass.
- [ ] **18 `desktop.ini` files are committed to git and published live** — e.g.
      <https://riganti.com.au/project/dining/desktop.ini> returns HTTP 200. OneDrive
      droppings from before the repo moved to `C:\Git`. Delete and add to `.gitignore`.
- [ ] **Expect a large diff on first deploy.** Hugo changed its processed-image filename
      scheme (`featured_hu<md5>_<bytes>_1500x1000_fill_q90_lanczos_smart1.jpg` →
      `featured_hu_<hash>.jpg`), so all 41 generated images get new names. Content is
      identical; it just makes the first `public/` commit noisy.
- [x] **Two upgrade side-effects that are improvements, not regressions:** internal links
      are now consistently trailing-slashed (the old build emitted both `/page1` and
      `/page1/`, costing a redirect), and `+` in URLs is entity-encoded as `&#43;`, which
      browsers decode identically.
- [ ] **Commit the theme fixes** to the `Academia-hugo` fork and bump the submodule pointer.
- [ ] **Theme folder case mismatch.** Config says `theme = "academia-hugo"`, folder is
      `Academia-hugo`. Works on Windows, will fail on Linux CI. Make them match.
- [ ] **No CI/CD.** Deploys are a manual `public/` submodule commit. Move to a GitHub
      Actions workflow that builds and pushes to the Pages repo on every push to master.
- [ ] **Stale `public/` submodule pointer** — source repo points at a Mar 2020 commit while
      the live site is Mar 2022.
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

- [ ] **No structured data at all** (zero JSON-LD on the site). Add `Person` + `WebSite`
      sitewide, `BreadcrumbList` on nested pages, and `HowTo` or `Article` on build pages.
      The build write-ups are step-by-step with photos — strong rich-result candidates.
- [ ] **`robots.txt` has no `Sitemap:` line.** It is literally just `User-agent: *`.
- [ ] **Multiple `<h1>` per page** — the search box emits one and the hero emits two more.
- [ ] **Every project dated 2020-02-19**, minutes `00:22`–`00:59`, because dates were used
      to force display order. Sitemap `lastmod` is therefore meaningless and there is no
      freshness signal anywhere. Fix alongside the sorting work below.
- [ ] **`og:image` is `mustangB.jpg` sitewide** — a generic car photo on every share card.
      Use each project's `featured.jpg` per page.
- [ ] **`og:updated_time` frozen at 2020-02-19.**
- [ ] **Thin taxonomy pages** — `/authors/` and `/publication_types/` are generated but
      carry nothing. Drop those taxonomies (this site has no publications).
- [ ] **Duplicate meta descriptions** — the sitewide description repeats on many pages.
- [ ] **Redundant titles** — "Projects | Mark Riganti's Projects".
- [ ] **Typos in public titles:** "Wahnao"/"Wanaho" vs "Wanhao", "Regidity" in a card
      description.

## P3 — Performance / Core Web Vitals

- [ ] **102 MB of images, 411 JPEGs, zero WebP/AVIF.** Largest single file is
      `static/img/slider/shuffle.JPG` at 4.2 MB — and it is in the above-the-fold slider.
- [ ] **No lazy loading anywhere** (0 of 18 images on a sample build page).
- [ ] **No `srcset`.** Images live in `static/`, which bypasses Hugo's image pipeline
      entirely. Moving them into page bundles enables automatic resizing + WebP/AVIF.
- [ ] **No `width`/`height` on images** → cumulative layout shift.
- [ ] **Render-blocking CDN assets, all ancient:** FontAwesome 5.6 (2018),
      academicons 1.8.6, fancybox 3.2.5, jQuery. Self-host and subset, or drop.

## P4 — Features

- [ ] **Project sorting** — see below.
- [ ] **Comment system** — see below.
- [ ] **Add projects completed since 2022.**

---

## Project sorting

Currently `portfolio.html` does `range where site.RegularPages "Type" "project"`.
Hugo's default order is **weight → date (desc) → title**, and since no project has a
`weight`, order falls through to date — which is why you incremented the minutes.

Proposed fix:

1. Add explicit `weight:` to each project for the curated order. That is what Hugo's
   weight field is for and it frees up `date`.
2. Set `date:` to each project's **real** date. This restores sitemap `lastmod`,
   structured-data `datePublished`, and makes "newest" meaningful.
3. Add sort controls to the portfolio widget. Isotope is already loaded for the filter
   buttons and supports `sortBy`, so **Default** / **Newest** can be client-side with
   no page reload and no extra dependency.

Needs from you: the real (even approximate) dates for the 41 existing projects, or
permission to infer them from git history and EXIF data on the photos.

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
