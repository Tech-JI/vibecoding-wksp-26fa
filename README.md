# Vibe Coding Workshop

The current priority is to develop **`slides/agent-tutorial.md`**: refine the material on agents and check the layout of the generated PDF. Use this deck as the default focus for further work. Hands-on exercises belong in a separate worksheet.

- Main deck: `slides/agent-tutorial.md`
- Image assets: `slides/assets/agent-tutorial/`
- Generated PDF: `output/pdf/agent-tutorial.pdf`
- `slides/workshop.md` is a compilation example, `slides/vibe_coding_workshop_slides.md` is an earlier draft, and `references/` contains reference material.

## Build

Requires Make, Pandoc, and Tectonic. The deck uses the macOS font PingFang SC; adjust the font configuration before building on other systems.

Run from the project root:

```sh
make agent
```

This generates `output/pdf/agent-tutorial.pdf`. On macOS, open it with:

```sh
open output/pdf/agent-tutorial.pdf
```

Run `make agent` again after editing the deck. Tectonic may download TeX dependencies during the first build. Image paths are relative to the project root; `##` starts a slide, and `#` starts a section.

Note: `make build` compiles the example deck by default. Use `make agent` for the main deck.

## Repository contents

Commit the slide sources in `slides/`, their assets in `slides/assets/`, this README, and the Makefile. Keep assets needed by the slides in `slides/assets/` rather than linking to local research folders.

The `.gitignore` excludes `output/` (generated PDFs, previews, and archives), `tmp/`, `downloads/`, `references/`, and the original chart captures at the project root. These files stay on your computer. PDF assets inside `slides/assets/` remain eligible for version control.

The `part1` branch contains the slide sources and assets. The `main` branch contains the published `agent-tutorial.pdf` and uses Git LFS for PDFs. Build the presentation with `make agent`, then update the PDF on `main` when publishing a workshop version.
