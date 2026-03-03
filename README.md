# The Tuva Project Blog (Quarto)

This repository hosts the Tuva Project Blog as a Quarto site.

The current implementation uses Quarto's `website` project type with a custom landing page, custom global header, card-based article directory, and article pages with a right-side table of contents.

## Purpose

The goal of this project is to publish practical knowledge about doing healthcare analytics.

## Tech Stack

- Quarto (site build and search index generation)
- Markdown/Quarto (`.qmd`) for content
- Custom HTML/CSS/JS for landing page and header behavior
- Static hosting (for example Netlify) serving the generated `_book/` output

## Key Files

- `_quarto.yml`: Quarto project config and chapter list
- `index.qmd`: Landing page card grid and client-side search logic
- `about.qmd`: About and contributor guidance page
- `global-header.html`: Shared top header injected on all pages
- `home.css`: Global theme, header, landing page, cards, and shared responsive rules
- `article.css`: Article page layout, title/byline, and right-side TOC behavior
- `img/blog/`: Hero/card images
- `_book/`: Generated static site output (build artifact)

## Local Development

Prerequisite: install Quarto.

Build the site:

```bash
quarto render
```

Preview with Quarto:

```bash
quarto preview
```

If you want to serve the already-rendered `_book/` output directly:

```bash
python3 -m http.server 5117 -d _book
```

Then open `http://127.0.0.1:5117`.

## How Content Is Organized

- A post is a `.qmd` file in the project root.
- A post appears in the site only if it is listed under `project.render` in `_quarto.yml`.
- The landing page cards are manually authored in `index.qmd`.

## Add a New Article

1. Create a new `.qmd` file with front matter (`title`, `date`, `toc`, etc).
2. Add a hero image under `img/blog/`.
3. Add a card entry in `index.qmd`.
4. Add the `.qmd` file to `project.render` in `_quarto.yml`.
5. Run `quarto render` and verify page layout, links, and search behavior.

## Search Behavior (Important)

Search on the landing page is custom and intentionally searches article body content, not only titles.

How it works:

- Quarto generates `_book/search.json` on each render.
- The script in `index.qmd` fetches `search.json`.
- It merges indexed section/body text into each card's searchable corpus.
- The search input in the header filters visible cards in real time.

Implication: you do not manually maintain `search.json`. It refreshes when `quarto render` (or hosting build) runs.

## Header and Layout Rules

- `global-header.html` is included on every page.
- Home page shows brand + `About` link + search bar.
- Article pages show brand only.
- Article pages render content column plus a right-side sticky TOC.
- TOC is intentionally plain text style (no widget box/border).

These behaviors are controlled by page-level CSS classes set at runtime in `global-header.html`:

- `is-home` vs `is-article`
- `has-toc` vs `no-toc`

## Deployment Notes

For Netlify (or similar static host):

- Build command: `quarto render`
- Publish directory: `_book`
- Local build/cache artifacts (`_book/`, `.quarto/`, `_freeze/`, `.ipynb_checkpoints/`) are intentionally gitignored.

Because Quarto renders from source on each build, generated assets like `search.json` stay current automatically.

## Maintenance Checklist

When changing layout or navigation:

1. Check `index.html` (home).
2. Check `about.html`.
3. Check at least one long article page with TOC.
4. Check desktop and mobile widths.
5. Confirm header behavior matches expectations on home vs article pages.
6. Confirm landing page search still returns expected content terms.

## Contributor Workflow

- Open a branch for your changes.
- Keep content and style changes scoped.
- Include screenshots for visual changes.
- Open a PR with summary, testing notes, and any follow-up items.
