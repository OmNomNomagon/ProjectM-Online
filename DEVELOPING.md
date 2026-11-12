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

Two commits, because `public/` is a submodule with its own history. This is the manual
process the site has always used — replacing it with a GitHub Actions workflow is on the
checklist (P1).

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
