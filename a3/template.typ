#let INDENT_WIDTH = 12pt
#let NUM_GUTTER = 0.6em

#let indent-width = INDENT_WIDTH
#let num-gutter = NUM_GUTTER
#let heading-num-width = state("heading-num-width", 0pt)
#let in-table = state("in-table", false)
#let num-width = heading-num-width

#let auto-indent(it) = context {
  if in-table.get() {
    it
  } else {
    let marks = query(selector(metadata).before(here(), inclusive: false))
    let depth = marks.filter(m => m.value == "__indent-open").len() - marks.filter(m => m.value == "__indent-close").len()
    if depth > 0 {
      it
    } else {
      let h = query(selector(heading).before(here())).at(-1, default: none)
      if h == none {
        it
      } else {
        let current-num-width = heading-num-width.get()
        block(inset: (left: indent-width * h.level + current-num-width))[
          #it
        ]
      }
    }
  }
}

#let project(
  title: "",
  authors: (),
  course: "",
  group: "",
  teacher: "",
  lang: "es",
  doc,
) = {
  set text(
    font: "carlito",
    size: 12pt,
    hyphenate: true,
    lang: lang,
  )

  set page(margin: (x: 2cm, y: 2.2cm))

  set par(
    justify: true,
    first-line-indent: 0pt,
    spacing: 0.75em,
    leading: 0.6em,
  )

  set heading(numbering: (..nums) => {
    let vals = nums.pos()
    if vals.len() == 1 {
      numbering("1.", vals.last())
    } else if vals.len() == 2 {
      numbering("1.1.", ..vals)
    } else if vals.len() == 3 {
      numbering("1.1.1.", ..vals)
    } else {
      numbering("1.1.1.1.", ..vals)
    }
  })
  show heading: set text(size: 12pt, weight: "bold")
  show heading: set block(above: 1.15em, below: 0.75em)

  show heading: it => {
    let num-content = if it.numbering != none {
      counter(heading).display(it.numbering)
    } else {
      none
    }
    let current-num-width = if num-content != none {
      measure(num-content).width + num-gutter
    } else {
      0pt
    }
    heading-num-width.update(current-num-width)
    block(inset: (left: indent-width * it.level))[
      #grid(
        columns: (current-num-width, 1fr),
        num-content,
        it.body,
      )
    ]
  }

  show figure.where(kind: table): set block(breakable: true)
  set table.cell(breakable: false)

  show list.item: it => {
    let kids = it.body.at("children", default: none)
    if kids != none and kids.len() > 0 and kids.at(0).func() == metadata and kids.at(0).at("value", default: "") == "__indent-open" {
      it
    } else {
      list.item[#metadata("__indent-open")#it.body#metadata("__indent-close")]
    }
  }
  show enum.item: it => {
    let kids = it.body.at("children", default: none)
    if kids != none and kids.len() > 0 and kids.at(0).func() == metadata and kids.at(0).at("value", default: "") == "__indent-open" {
      it
    } else {
      enum.item[#metadata("__indent-open")#it.body#metadata("__indent-close")]
    }
  }

  show par: auto-indent
  show enum: auto-indent
  show list: auto-indent
  show bibliography: auto-indent
  show figure: auto-indent
  show raw.where(block: true): auto-indent

  show figure.where(kind: table): set text(size: 8.5pt)
  show table.cell.where(y: 0): set text(weight: "bold")
  set table(
    fill: (col, row) => if row == 0 { rgb("e5e7eb") } else { none },
    stroke: (x, y) => 0.5pt + luma(180),
  )
  show table: it => {
    in-table.update(true)
    it
    in-table.update(false)
  }

  show figure.caption: it => [
    #it.supplement #context it.counter.display(it.numbering). #it.body
  ]

  align(center)[
    #set par(leading: 1.2em, spacing: 1.6em)
    #if lang == "en" [
      #strong[NATIONAL UNIVERSITY OF SAN AGUSTIN]\
      #strong[FACULTY OF PRODUCTION AND SERVICES ENGINEERING]\
      #strong[PROFESSIONAL SCHOOL OF SYSTEMS ENGINEERING]\

      #v(0.6em)
      #image("img/logo.png", width: 3.8cm)
      #v(0.6em)

      #strong[PRACTICAL ACTIVITY]\
      #title\

      #v(0.6em)
      #strong[COURSE]\
      #course\
      #if group != "" [#group\ ]

      #v(0.6em)
      #strong[INSTRUCTOR]\
      #teacher\

      #v(0.6em)
      #strong[MEMBERS]\
      #authors.join("\n")\

      #v(0.8em)
      #strong[AREQUIPA - PERU]\
      #strong[2026]
    ] else [
      #strong[UNIVERSIDAD NACIONAL DE SAN AGUSTÍN]\
      #strong[FACULTAD DE INGENIERÍA DE PRODUCCIÓN Y SERVICIOS]\
      #strong[ESCUELA PROFESIONAL DE INGENIERÍA DE SISTEMAS]\

      #v(0.6em)
      #image("img/logo.png", width: 3.8cm)
      #v(0.6em)

      #strong[ACTIVIDAD PRÁCTICA]\
      #title\

      #v(0.6em)
      #strong[ASIGNATURA]\
      #course\
      #if group != "" [#group\ ]

      #v(0.6em)
      #strong[DOCENTE]\
      #teacher\

      #v(0.6em)
      #strong[INTEGRANTES]\
      #authors.join("\n")\

      #v(0.8em)
      #strong[AREQUIPA - PERÚ]\
      #strong[2026]
    ]
  ]

  pagebreak()

  set page(
    numbering: "1",
    number-align: center,
  )
  counter(page).update(1)

  set par(leading: 0.6em)

  align(center)[
    #set text(size: 14pt, weight: "bold")
    #block(below: 1.2em)[#title]
  ]

  doc
}
