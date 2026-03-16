# UniUD Quarto Extension

A [Quarto](https://quarto.org) extension for the University of Udine, providing:

- **RevealJS slides** — themed presentation format with UNIUD branding
- **Typst lecture notes** — printable PDF notes with UNIUD layout

## Installation
```bash
quarto add iolab-uniud/quarto-uniud
```

## Usage

### RevealJS slides

In your document frontmatter:
```yaml
---
title: "My Lecture"
format: iolab-uniud/uniud-revealjs
---
```

Or in `_quarto.yml` for a full project:
```yaml
format:
  iolab-uniud/uniud-revealjs:
    slide-number: true
    chalkboard: true
    logo: "images/uniud_logotipo blu_03.svg"
    code-line-numbers: true
    highlight-style: github
    incremental: false
```

### Typst lecture notes
```yaml
format:
  iolab-uniud/uniud-typst: default
```

Add a `course` field to your frontmatter (or to a `_metadata.yml` inside each
week folder) to populate the header and title page:
```yaml
---
title: "Lists and Data Structures"
course: "Programming and Data Analysis — A.Y. 2025/2026"
date: "March 2026"
---
```

Render only the Typst format:
```bash
quarto render week-1 --to iolab-uniud/uniud-typst
```

### Conditional content (slides vs. notes)

Use Quarto's built-in visibility classes to show content only in one format:
```markdown
::: {.content-visible when-format="revealjs"}
This appears only in slides.
:::

::: {.content-visible when-format="typst"}
This appears only in the lecture notes.
:::
```

## Repository structure
```
_extensions/
└── uniud/
    ├── _extension.yml      # format definitions
    ├── uniud.scss          # RevealJS theme
    ├── mathjax-config.js   # MathJax v4 configuration
    ├── uniud-notes.typ     # Typst layout template
    └── typst-show.typ      # Pandoc partial (Quarto→Typst wiring)
```

## Requirements

- Quarto ≥ 1.3.0
- Typst (bundled with Quarto ≥ 1.4)

## Notes

The RevealJS theme is based on
[Grant McDermott's clean template](https://github.com/grantmcdermott/quarto-revealjs-clean).