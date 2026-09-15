// The fixed chrome above and below the card grid.
//
// Both take the whole sheet so that a cheatsheet only has to supply the
// fields it cares about; everything here has a fallback.

#import "styles.typ": *
#import "components.typ": cap, tile

#let opt(sheet, key, fallback) = sheet.at(key, default: fallback)

#let legend-box(sheet) = {
  let legend = opt(sheet, "legend", ())
  if legend.len() == 0 {
    none
  } else {
    let accent = rgb(sheet.cards.first().accent)
    box(
      radius: 10pt * chrome,
      inset: (x: 16pt * chrome, y: 11pt * chrome),
      fill: panel,
      stroke: 1pt + hair,
      legend
        .map(l => {
          cap(l.key, accent, u: chrome, w: 46pt * chrome)
          h(7pt * chrome)
          text(size: 9.5pt * chrome, fill: fg-dim, "= " + l.label)
        })
        .join(h(18pt * chrome)),
    )
  }
}

#let header(sheet) = grid(
  columns: (auto, auto, auto, 1fr, auto),
  column-gutter: (14pt, 24pt, 24pt, 0pt),
  align: horizon,
  tile(opt(sheet, "mark", 0xf11c), rgb(sheet.cards.first().accent), size: 44pt),
  {
    text(
      size: 25pt,
      weight: 800,
      tracking: 3.5pt,
      fill: fg,
      upper(opt(sheet, "title", sheet.name)),
    )
    linebreak()
    v(3pt)
    text(
      size: 9.5pt,
      weight: 600,
      tracking: 3.6pt,
      fill: fg-dim,
      upper(opt(sheet, "subtitle", "Cheatsheet")),
    )
  },
  box(width: 1pt, height: 46pt, fill: hair),
  legend-box(sheet),
  text(
    font: mono,
    size: 11pt,
    weight: 700,
    tracking: 1.4pt,
    fill: fg-mute,
    str(sheet.index) + " / " + str(sheet.total),
  ),
)

#let footer(sheet) = {
  let accent = rgb(sheet.cards.first().accent)
  grid(
    columns: (auto, 1fr, auto),
    column-gutter: 14pt * chrome,
    align: horizon,
    text(
      size: 9.5pt * chrome,
      weight: 700,
      tracking: 1.6pt * chrome,
      fill: fg-dim,
      upper(sheet.name),
    ),
    text(size: 9.5pt * chrome, fill: fg-mute, opt(sheet, "footer", "")),
    {
      cap("←", accent, u: chrome, w: 26pt * chrome)
      h(4pt * chrome)
      cap("→", accent, u: chrome, w: 26pt * chrome)
      h(9pt * chrome)
      text(size: 9pt * chrome, fill: fg-mute, "navigate")
      h(22pt * chrome)
      cap("ESC", accent, u: chrome, w: 36pt * chrome)
      h(9pt * chrome)
      text(size: 9pt * chrome, fill: fg-mute, "close")
    },
  )
}
