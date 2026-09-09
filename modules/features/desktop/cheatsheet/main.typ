// Entry point. `default.nix` drops `sheet.json` next to this file and
// compiles it to a single PNG.

#import "styles.typ": *
#import "components.typ": card
#import "bands.typ": footer, header

#let sheet = json("sheet.json")

#show: conf

// Height of each grid row, at metric scale `u`: the tallest card in it.
#let row-heights(u) = {
  let nat = sheet.cards.map(c => measure(block(width: col-w, card(c, u: u))).height)
  let n = calc.ceil(sheet.cards.len() / cols)
  range(n).map(r => calc.max(..nat.slice(r * cols, calc.min((r + 1) * cols, nat.len()))))
}

#let stack-height(rows) = rows.sum() + (rows.len() - 1) * gut

#context {
  let inner-w = page-w - 2 * pad
  let head-h = measure(block(width: inner-w, header(sheet))).height
  let foot-h = measure(block(width: inner-w, footer(sheet))).height
  let grid-h = page-h - 2 * pad - head-h - foot-h - 4 * band - 2pt

  // Row heights grow ~linearly with `u`, so one pass estimates the scale
  // that fills the page and a second pass confirms it.
  let rows = row-heights(1.0)
  let u = calc.min(1.75, grid-h / stack-height(rows))
  let rows = row-heights(u)

  // Never overflow: shrink until it fits, then stop.
  while stack-height(rows) > grid-h and u > 0.55 {
    u = u * 0.94
    rows = row-heights(u)
  }

  assert(
    stack-height(rows) <= grid-h,
    message: "cheatsheet '" + sheet.name + "' has too many rows to fit one page",
  )

  stack(
    dir: ttb,
    header(sheet),
    v(band),
    line(length: 100%, stroke: 1pt + hair),
    v(band),
    block(
      width: 100%,
      height: grid-h,
      align(horizon + left, grid(
        columns: (col-w,) * cols,
        rows: rows,
        column-gutter: gut,
        row-gutter: gut,
        ..sheet
          .cards
          .enumerate()
          .map(((i, c)) => card(c, u: u, h: rows.at(calc.floor(i / cols)))),
      )),
    ),
    v(band),
    line(length: 100%, stroke: 1pt + hair),
    v(band),
    footer(sheet),
  )
}
