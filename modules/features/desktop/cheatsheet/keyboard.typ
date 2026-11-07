// Split-keyboard layer drawings, for sheets that set `layers` instead of
// `cards`. A layer is its keys in board order (three rows of ten, then the
// thumbs) plus optional two-key combos drawn between their keys.

#import "styles.typ": *

// Material Design icons by keymap-drawer name, at their Nerd Font codepoints.
#let icons = (
  "apple-keyboard-shift": "\u{f0636}",
  "arrow-collapse-left": "\u{f0793}",
  "arrow-collapse-right": "\u{f0794}",
  "arrow-down": "\u{f0045}",
  "arrow-left": "\u{f004d}",
  "arrow-right": "\u{f0054}",
  "arrow-u-left-top": "\u{f17a7}",
  "arrow-u-right-top": "\u{f17ab}",
  "arrow-up": "\u{f005d}",
  "backspace-outline": "\u{f0b5c}",
  "bluetooth": "\u{f00af}",
  "bluetooth-off": "\u{f00b2}",
  "keyboard-esc": "\u{f12b7}",
  "keyboard-return": "\u{f0311}",
  "keyboard-space": "\u{f1050}",
  "keyboard-tab": "\u{f0312}",
  "keyboard-tab-reverse": "\u{f0325}",
  "linux": "\u{f033d}",
  "tab-minus": "\u{f0b4b}",
  "tab-plus": "\u{f075c}",
)

#let glyphs(s) = s.replace(
  regex("\$\$mdi:([a-z-]+)\$\$"),
  m => icons.at(m.captures.first(), default: "?"),
)

#let norm(k) = if type(k) == str { (t: k) } else { k }

#let keycap(k, accent, size) = {
  let k = norm(k)
  let held = k.at("held", default: false)
  let t = glyphs(k.at("t", default: ""))
  let blank = t == "" and not held
  let big = if t.clusters().len() > 3 { 0.21 } else { 0.32 }
  box(
    width: size,
    height: size,
    radius: size * 0.17,
    fill: if held { accent.transparentize(45%) } else if blank { panel } else {
      accent.transparentize(90%)
    },
    stroke: (size * 0.016)
      + if blank { hair } else { accent.transparentize(50%) },
    {
      if "s" in k {
        place(top + center, dy: size * 0.07, text(
          font: mono,
          size: size * 0.15,
          fill: fg-dim,
          glyphs(k.s),
        ))
      }
      place(center + horizon, text(
        font: mono,
        size: size * big,
        weight: 600,
        fill: fg,
        t,
      ))
      if "h" in k {
        place(bottom + center, dy: -size * 0.07, text(
          font: mono,
          size: size * 0.15,
          weight: 600,
          fill: accent,
          glyphs(k.h),
        ))
      }
    },
  )
}

// Gutter between keys, and the gap between the halves, as parts of a key.
#let key-gut = 0.12
#let split = 0.7

// Board width and height for key size `size`.
#let board-w(size) = size * (10 + 9 * key-gut + split)
#let board-h(size) = size * (4 + 3 * key-gut)

// Left edge of column `c` (0-9).
#let col-x(c, size) = {
  let step = size * (1 + key-gut)
  if c < 5 { c * step } else { c * step + size * split }
}

#let board(layer, size) = {
  let accent = rgb(layer.accent)
  let keys = layer.keys
  let step = size * (1 + key-gut)
  let at(c, r, k) = place(top + left, dx: col-x(c, size), dy: r * step, keycap(
    k,
    accent,
    size,
  ))

  box(width: board-w(size), height: board-h(size), {
    for r in range(3) {
      for c in range(10) { at(c, r, keys.at(r * 10 + c)) }
    }
    // Left thumbs sit under columns 2-4, right thumbs under columns 5-7.
    for (i, c) in (2, 3, 4, 5, 6, 7).enumerate() { at(c, 3, keys.at(30 + i)) }

    for combo in layer.at("combos", default: ()) {
      let (a, b) = combo.keys
      let row = calc.floor(a / 10)
      let x = (
        (col-x(calc.rem(a, 10), size) + col-x(calc.rem(b, 10), size) + size) / 2
      )
      let d = size * 0.4
      place(top + left, dx: x - d / 2, dy: row * step + size * 0.18, box(
        width: d,
        height: d,
        radius: d * 0.3,
        fill: accent.darken(35%),
        stroke: (size * 0.016) + accent,
        align(center + horizon, text(
          font: mono,
          size: d * 0.5,
          fill: fg,
          glyphs(combo.k),
        )),
      ))
    }
  })
}

// One layer in a panel: name, subtitle, then the board.
#let layer-card(layer, size, w, cell-h) = {
  let accent = rgb(layer.accent)
  block(
    width: w,
    height: cell-h,
    radius: 13pt,
    fill: panel,
    stroke: 1.1pt + accent.transparentize(58%),
    inset: (x: 22pt, y: 16pt),
    stack(
      dir: ttb,
      spacing: 14pt,
      {
        text(size: 15pt, weight: 800, tracking: 0.8pt, fill: accent, upper(
          layer.name,
        ))
        h(12pt)
        text(size: 10pt, fill: fg-dim, layer.at("subtitle", default: ""))
      },
      align(center, board(layer, size)),
    ),
  )
}

// Layers on a two-column grid filling `w` x `h`, with the largest key size
// that fits every board.
#let layer-grid(layers, w, h) = {
  let rows = calc.ceil(layers.len() / 2)
  let cell-w = (w - gut) / 2
  let cell-h = (h - (rows - 1) * gut) / rows
  let head = 15pt * 1.3 + 14pt
  let size = calc.min(
    (cell-w - 44pt) / (10 + 9 * key-gut + split),
    (cell-h - 32pt - head) / (4 + 3 * key-gut),
  )
  grid(
    columns: (cell-w,) * 2,
    column-gutter: gut,
    row-gutter: gut,
    ..layers.map(l => layer-card(l, size, cell-w, cell-h)),
  )
}
