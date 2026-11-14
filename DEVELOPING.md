# Local development

## One-time setup

Hugo **Extended** 0.169.0 is already installed via winget. To reproduce on another machine:

```
winget install Hugo.Hugo.Extended
git clone --recurse-submodules https://github.com/OmNomNomagon/ProjectM-Online.git
```

The `--recurse-submodules` matters: the theme and the live site are both submodules.

## Preview changes live

```
.\scripts\serve.ps1
```

Opens <http://localhost:1313> with LiveReload. Save any file under `content/`,
`config/` or `themes/` and the browser refreshes on its own — this is the loop for
confirming each change before it goes anywhere near the live site.

Options: `-Port 8080` to change port, `-Drafts` to include `draft: true` pages.

In the Claude desktop app the same server is available in the **Browser** pane as
`riganti-dev`, so changes can be checked without leaving the editor.

## Check a build without touching anything

```
.\scripts\build.ps1
```

Builds into a throwaway temp folder, prints warnings separately from errors, and exits
non-zero if Hugo reports any ERROR. `.\public` is left alone. Run this before deploying.

## Deploy

**Automatic (normal):** push to `master` on GitHub. The workflow in
`.github/workflows/deploy.yml` builds the site on Linux with Hugo 0.169.0 extended,
checks for empty images, and replaces the contents of the Pages repo
(`OmNomNomagon.github.io`) with the build. Watch it under the repo's **Actions** tab;
it can also be run by hand there ("Run workflow"). The first run converts every image
(~2 minutes); later runs reuse them from the cache.

It needs a deploy key (one-time setup):

1. Make a key pair in a scratch folder (no passphrase):
   `ssh-keygen -t ed25519 -C riganti-deploy -f riganti_deploy -N ""`
2. **OmNomNomagon.github.io** → Settings → Deploy keys → Add deploy key: paste
   `riganti_deploy.pub`, tick **Allow write access**.
3. **ProjectM-Online** → Settings → Secrets and variables → Actions → New repository
   secret: name `PAGES_DEPLOY_KEY`, value = the whole of `riganti_deploy` (the private key).
4. Delete both key files.

The key can only write to the Pages repo. Because the workflow publishes the whole
build, the `public/` submodule in this repo no longer needs updating; it may lag
behind the live site, which is fine.

Linux is case-sensitive: file names in Markdown (`![](I01.jpg)`) and the theme name in
config must match the files exactly, or the GitHub build fails where Windows works.

**Manual (fallback):**

```
.\scripts\build.ps1 -Deploy
```

Builds into `.\public`, which is the `OmNomNomagon.github.io` submodule. Then:

```
cd public
git add -A
git commit -m "Rebuild site"
git push
cd ..
git add public
git commit -m "Update site submodule"
git push
```

Two commits, because `public/` is a submodule with its own history. Only needed if the
workflow above is unavailable.

## Adding a project

Everything for a project lives in one folder, `content/build/<name>/`. Create it from
the template:

```
hugo new content build/<name>
```

(`<name>` becomes the address, e.g. `build/walnut-desk` → riganti.com.au/build/walnut-desk/.)
That makes `index.md` (the write-up, with the card settings at the top) and `slider.md`.
Then drop the photos into the same folder:

| File | What it's for |
|---|---|
| `featured.jpg` | The homepage grid card and the share image (landscape works best) |
| `G1.jpg`, `G2.jpg`, … | The slider at the top of the page, in name order |
| any other photo | Placed in the text with `![What it shows](photo.jpg)` |

Use the original photos: Hugo resizes them and converts them to AVIF/WebP, makes phone
crops for the slider, and sets sizes so pages don't jump while loading. Write a short
description inside the `[ ]` of each photo; it becomes the alt text (left empty, it
falls back to "<title> – build photo N").

In `index.md`: `title`, `summary` (the card's one-liner), `description` (search
results, ~120–160 characters), `tags` (wood / 3d / audio / electro / dev; the first is
the card's type) and `card_weight` (grid position: existing projects run 200–2200 in
steps of 50, so 100 puts a new one first). `card_title` / `card_summary` give the card
shorter wording than the page. Set `date` to when you built it: the grid's "Newest"
sort uses it.

Older notes: card pages used to live in `content/project/` with photos in
`static/img/project/`; everything moved into the project folders on 2026-11-14, and the
old `/project/<name>/` addresses redirect (`aliases` in each page).

## Adding a new documentation set

A docs chapter (like `content/docs/mk3x/`) needs **both** of these in its `_index.md`,
or it renders without the sidebar:

```yaml
type: docs
layout: chapter
```

`type: docs` picks the docs templates; `layout: chapter` picks the full layout with the
sidebar, as opposed to `/docs/` itself which lists the available chapters. Sidebar
entries come from each page's `menu:` front matter block.

## Gotchas

- **`sed -i` rewrites CRLF to LF** on these files, which makes git show the whole file as
  changed. Use an editor, or check `git diff --stat` afterwards.
- **`hugo server` only watches directories that existed when it started.** Create a new
  top-level folder (e.g. `layouts/`) and you must restart the server.
- **Config changes don't always reload.** If a `config/_default/*.toml` edit seems to do
  nothing, restart the server rather than assuming the change was wrong.
- **Hugo serialises builds on `.hugo_build.lock`.** Running `build.ps1` while the preview
  server is up would hang forever, so the script passes `--noBuildLock`.
- **Never run a bare `hugo server` here.** Since Hugo 0.123 the server renders to
  `publishDir` *on disk* by default, and `publishDir` is `./public` — the live-site
  submodule. A bare `hugo server` therefore fills the deploy repo with pages carrying
  injected `livereload` `<script>` tags pointing at `localhost:1313`, which would go
  straight to production on the next deploy. `serve.ps1` passes `--renderToMemory` to
  prevent this. If `public/` ever shows unexpected modifications, that is the cause:
  `cd public && git reset --hard origin/master`.
- **`paginate` is dead.** Use `[pagination].pagerSize`. The old key is ignored *silently*
  and list pages quietly fall back to 10 items per page.

## Layout

```
config/_default/     site config (config, params, menus, languages)
content/project/     41 portfolio cards -> each links to a build page
content/build/       36 build write-ups
content/docs/mk3x/   14-page MK3x printer manual
content/home/        homepage widgets (slider, projects, contact)
static/img/          102 MB of images (not run through Hugo's image pipeline - see P3)
themes/Academia-hugo/  submodule, your fork of the Themefisher Academia theme
public/              submodule, the built site that GitHub Pages serves
scripts/             serve / build helpers
```
