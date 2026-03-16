// ================================================================
//  UNIUD Lecture Notes
// ================================================================

#let uniud-notes(
  title:    none,
  subtitle: none,
  authors:  (),
  date:     none,
  course:   none,
  body,
) = {

  set document(
    title:  title,
    author: authors.map(a => a.at("name", default: "")),
  )

  // ── Colori ────────────────────────────────────────────────────
  let uniud-blue  = rgb("#003DA5")
  let gray-mid    = rgb("#555555")
  let gray-light  = rgb("#CCCCCC")
  let code-bg     = rgb("#F5F7FA")
  let code-border = rgb("#D0D7E3")

  // ── Pagina ────────────────────────────────────────────────────
  set page(
    paper:  "a4",
    margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.2cm),

    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, auto),
          align:   (left + horizon, right + horizon),
          text(size: 8.5pt, fill: gray-mid, style: "italic")[#title],
          image("/images/uniud_logotipo blu_03.svg", height: 0.55cm),
        )
        v(-4pt)
        line(length: 100%, stroke: 0.5pt + uniud-blue)
      }
    },

    footer: context {
      if counter(page).get().first() > 1 {
        line(length: 100%, stroke: 0.4pt + gray-light)
        v(-4pt)
        grid(
          columns: (1fr, auto),
          align:   (left + horizon, right + horizon),
          text(size: 8pt, fill: gray-mid)[#course],
          text(size: 8pt, fill: gray-mid)[
            #counter(page).display() / #counter(page).final().first()
          ],
        )
      }
    },
  )

  // ── Tipografia ────────────────────────────────────────────────
  set text(font: ("Linux Libertine", "Georgia", "Times New Roman"),
           size: 11pt, lang: "it")
  set par(justify: true, leading: 0.72em, spacing: 1.2em)

  // ── Titoli ────────────────────────────────────────────────────
  set heading(numbering: "1.1  ")

  show heading.where(level: 1): it => {
    v(1.4em, weak: true)
    block[
      #text(size: 15pt, weight: "bold", fill: uniud-blue)[
        #counter(heading).display("1  ")#it.body
      ]
      #v(2pt)
      #line(length: 100%, stroke: 1.2pt + uniud-blue)
    ]
    v(0.6em, weak: true)
  }

  show heading.where(level: 2): it => {
    v(1.1em, weak: true)
    text(size: 12.5pt, weight: "bold", fill: uniud-blue)[
      #counter(heading).display("1.1  ")#it.body
    ]
    v(0.4em, weak: true)
  }

  show heading.where(level: 3): it => {
    v(0.9em, weak: true)
    text(size: 11pt, weight: "semibold", fill: gray-mid)[#it.body]
    v(0.3em, weak: true)
  }

  // ── Codice ────────────────────────────────────────────────────
  show raw.where(block: true): it => block(
    fill:   code-bg,
    stroke: 0.5pt + code-border,
    radius: 4pt,
    inset:  (x: 14pt, y: 10pt),
    width:  100%,
    text(
      font: ("JetBrains Mono", "Fira Code", "Cascadia Code", "Courier New"),
      size: 9pt,
      it,
    ),
  )

  show raw.where(block: false): it => box(
    fill:   rgb("#EAEEF5"),
    stroke: 0.3pt + code-border,
    radius: 2pt,
    inset:  (x: 3pt, y: 1pt),
    text(
      font: ("JetBrains Mono", "Fira Code", "Cascadia Code", "Courier New"),
      size: 0.88em,
      it,
    ),
  )

  // ── Frontespizio ─────────────────────────────────────────────
  page(
    margin: (top: 3cm, bottom: 2.5cm, left: 2.5cm, right: 2.2cm),
    header: none,
    footer: none,
  )[
    #align(right)[
      #image("/images/uniud_logotipo blu_03.svg", width: 5cm)
    ]
    #v(2.5cm)

    #if course != none {
      text(size: 13pt, fill: uniud-blue, weight: "medium")[#course]
      v(0.5cm)
    }

    #text(size: 26pt, weight: "bold")[#title]

    #if subtitle != none {
      v(0.4cm)
      text(size: 15pt, fill: gray-mid)[#subtitle]
    }

    #v(0.8cm)
    #line(length: 100%, stroke: 2pt + uniud-blue)
    #v(0.6cm)

    #for a in authors [
      #text(size: 12pt, weight: "semibold")[#a.at("name", default: "")]
      #if "email" in a [
        \
        #text(size: 9pt, fill: uniud-blue)[
          #link("mailto:" + a.at("email"))[#a.at("email")]
        ]
      ]
      #v(0.25cm)
    ]

    #v(1fr)
    #if date != none {
      text(size: 9.5pt, fill: gray-mid)[#date]
    }
  ]

  // ── Indice ────────────────────────────────────────────────────
  outline(title: [Indice], depth: 2, indent: 1.2em)
  pagebreak(weak: true)

  body
}
```

---

**`_templates/typst-show.typ`** — partial Pandoc (attenzione: usa la sintassi `$...$` di Pandoc, **non** Typst):
```
#import "_templates/uniud-notes.typ": uniud-notes

#show: uniud-notes.with(
$if(title)$  title:    [$title$],$endif$
$if(subtitle)$  subtitle: [$subtitle$],$endif$
$if(date)$  date:     [$date$],$endif$
$if(course)$  course:   [$course$],$endif$
  authors: (
$for(by-author)$
    (
      name:  "$it.name.literal$"
$if(it.email)$      , email: "$it.email$"$endif$
    ),
$endfor$
  ),
)