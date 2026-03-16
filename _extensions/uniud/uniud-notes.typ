// ================================================================
//  UNIUD Lecture Notes — Typst template
//  Conforme al Manuale di Identità Visiva 2025
//  Font: Work Sans (Regular / SemiBold / Bold)
// ================================================================

#let uniud-notes(
  title:    none,
  subtitle: none,
  authors:  (),
  date:     none,
  course:   none,
  logo:     "/_extensions/iolab-uniud/uniud/assets/uniud-logo-blue.svg",
  body,
) = {

  set document(
    title:  title,
    author: authors.map(a => a.at("name", default: "")),
  )

  // ── Colori ufficiali UNIUD ────────────────────────────────────
  let uniud-blue  = rgb("#0000ff")   // Pantone 072 U
  let uniud-gray  = rgb("#b3b6b7")   // Pantone 877 U
  let jet         = rgb("#131516")
  let gray-mid    = rgb("#555555")
  let code-bg     = rgb("#f0f0ff")
  let code-border = rgb("#c0c0e8")

  // ── Font helper ───────────────────────────────────────────────
  // Work Sans Regular   — testo corrente
  // Work Sans SemiBold  — titoli h3, didascalie
  // Work Sans Bold      — titoli h1, h2, frontespizio
  let ws = "Work Sans"

  // ── Pagina base ───────────────────────────────────────────────
  set page(
    paper:  "a4",
    margin: (top: 2.8cm, bottom: 2.5cm, left: 2.5cm, right: 2.2cm),

    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, auto),
          align:   (left + horizon, right + horizon),
          gutter:  8pt,
          text(font: ws, size: 8.5pt, fill: gray-mid, style: "italic",
               weight: "regular")[#title],
          image(logo, height: 2cm),
        )
        v(-4pt)
        line(length: 100%, stroke: 0.5pt + uniud-blue)
      }
    },

    footer: context {
      if counter(page).get().first() > 1 {
        line(length: 100%, stroke: 0.4pt + uniud-gray)
        v(-4pt)
        grid(
          columns: (1fr, auto),
          align:   (left + horizon, right + horizon),
          text(font: ws, size: 8pt, fill: gray-mid, weight: "regular")[#course],
          text(font: ws, size: 8pt, fill: gray-mid, weight: "regular")[
            #counter(page).display() / #counter(page).final().first()
          ],
        )
      }
    },
  )

  // ── Tipografia base ───────────────────────────────────────────
  set text(font: ws, size: 11pt, lang: "it", weight: "regular")
  set par(justify: true, leading: 0.72em, spacing: 1.2em)

  // ── Titoli ────────────────────────────────────────────────────
  set heading(numbering: "1.1  ")

  show heading.where(level: 1): it => {
    v(1.4em, weak: true)
    block[
      #text(font: ws, size: 15pt, weight: "bold", fill: uniud-blue)[
        #counter(heading).display("1  ")#it.body
      ]
      #v(2pt)
      #line(length: 100%, stroke: 1.2pt + uniud-blue)
    ]
    v(0.6em, weak: true)
  }

  show heading.where(level: 2): it => {
    v(1.1em, weak: true)
    text(font: ws, size: 12.5pt, weight: "bold", fill: uniud-blue)[
      #counter(heading).display("1.1  ")#it.body
    ]
    v(0.4em, weak: true)
  }

  show heading.where(level: 3): it => {
    v(0.9em, weak: true)
    text(font: ws, size: 11pt, weight: "semibold", fill: gray-mid)[#it.body]
    v(0.3em, weak: true)
  }

  // ── Codice inline ─────────────────────────────────────────────
  show raw.where(block: false): it => box(
    fill:   code-bg,
    stroke: 0.3pt + code-border,
    radius: 2pt,
    inset:  (x: 3pt, y: 1pt),
    text(
      font:   ("Roboto Mono", "Courier New"),
      size:   0.88em,
      weight: "regular",
      it,
    ),
  )

  // ── Codice blocco ─────────────────────────────────────────────
  show raw.where(block: true): it => block(
    fill:   code-bg,
    stroke: (left: 3pt + uniud-blue, rest: 0.5pt + code-border),
    radius: (right: 4pt),
    inset:  (x: 14pt, y: 10pt),
    width:  100%,
    text(
      font:   ("Roboto Mono", "Courier New"),
      size:   9pt,
      weight: "regular",
      it,
    ),
  )

  // ── Link ──────────────────────────────────────────────────────
  show link: it => text(fill: uniud-blue, it)

  // ── Frontespizio ──────────────────────────────────────────────
  page(
    margin: (top: 3cm, bottom: 2.5cm, left: 2.5cm, right: 2.2cm),
    header: none,
    footer: none,
  )[
    #align(right)[
      #image(logo, width: 5cm)
    ]
    #v(2.5cm)

    #if course != none {
      text(font: ws, size: 13pt, weight: "bold", fill: uniud-blue)[#course]
      v(0.5cm)
    }

    #text(font: ws, size: 28pt, weight: "bold")[#title]

    #if subtitle != none {
      v(0.4cm)
      text(font: ws, size: 15pt, weight: "regular", style: "italic",
           fill: gray-mid)[#subtitle]
    }

    #v(0.8cm)
    #line(length: 100%, stroke: 2pt + uniud-blue)
    #v(0.6cm)

    #for a in authors [
      #text(font: ws, size: 12pt, weight: "bold")[#a.at("name", default: "")]
      #if "email" in a [
        \
        #let email = a.at("email").replace("\\@", "@")
        #text(font: ws, size: 9pt, weight: "regular", fill: uniud-blue)[
          #link("mailto:" + email)[#email]
        ]
      ]
      #v(0.25cm)
    ]

    #v(1fr)
    #if date != none {
      text(font: ws, size: 9.5pt, weight: "regular", fill: gray-mid)[#date]
    }
  ]

  // ── Indice ────────────────────────────────────────────────────
  show outline.entry.where(level: 1): it => {
    v(6pt, weak: true)
    text(font: ws, weight: "bold", it)
  }

  outline(
    title: text(font: ws, size: 15pt, weight: "bold",
                fill: uniud-blue)[
                  #if text.lang == "it" [Indice] else [Table of Contents]
                ],
    depth: 2,
    indent: 1.2em,
  )

  pagebreak(weak: true)

  // ── Corpo ─────────────────────────────────────────────────────
  body
}
