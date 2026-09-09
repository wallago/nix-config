#let sheet = json("sheet.json")

#let bg = rgb("#0a0e17")
#let card-bg = rgb("#0f1420")
#let fg = rgb("#e6edf3")
#let fg-dim = rgb("#8b98a9")

#set page(width: 1600pt, height: 900pt, margin: 26pt, fill: bg)
#set text(font: "Noto Sans", fill: fg)

#let keycap(label, accent) = box(
  inset: (x: 7pt, y: 4pt),
  radius: 4pt,
  fill: accent.transparentize(88%),
  stroke: 0.8pt + accent.transparentize(55%),
  text(font: "FiraCode Nerd Font", size: 9pt, weight: 600, fill: fg, label),
)

#let chips(r, accent) = {
  for m in r.mods {
    keycap(upper(m), accent)
    text(size: 9pt, fill: fg-dim, " + ")
  }
  keycap(upper(r.key), accent)
}

#let card(c) = {
  let accent = rgb(c.accent)

  block(
    width: 100%,
    height: 100%,
    fill: card-bg,
    radius: 10pt,
    stroke: 1pt + accent.transparentize(70%),
    inset: 16pt,
    {
      grid(
        columns: (auto, 1fr),
        column-gutter: 12pt,
        align: horizon,
        text(font: "FiraCode Nerd Font", size: 21pt, fill: accent, c.icon),
        {
          text(size: 15pt, weight: 700, fill: accent, upper(c.label))
          linebreak()
          text(size: 9.5pt, fill: fg-dim, c.subtitle)
        },
      )

      v(9pt)
      line(length: 100%, stroke: 1pt + accent.transparentize(65%))
      v(9pt)

      grid(
        columns: (auto, 1fr),
        column-gutter: 18pt,
        row-gutter: 7pt,
        align: (right + horizon, left + horizon),
        ..c.rows.map(r => (chips(r, accent), text(size: 10pt, r.title))).flatten(),
      )
    },
  )
}

#block(height: 100%, {
  block(
    height: 20pt,
    text(size: 12pt, weight: 700, fill: fg-dim, {
      upper(sheet.name)
      h(12pt)
      text(fill: fg-dim.transparentize(45%), [#sheet.index / #sheet.total])
    }),
  )

  v(12pt)

  block(
    height: 100% - 32pt,
    grid(
      columns: (1fr, 1fr, 1fr),
      rows: (1fr, 1fr),
      gutter: 18pt,
      ..sheet.cards.map(card),
    ),
  )
})
