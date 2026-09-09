// Building blocks: keycaps, icon tiles and the category card.
//
// Every size is a multiple of `u`, the metric scale `main.typ` solves for
// so that a sheet's content fills the page instead of floating in it.

#import "styles.typ": *

#let cap(label, accent, u: 1.0, w: auto) = box(
  width: w,
  height: 17pt * u,
  radius: 4.5pt * u,
  inset: (x: 7pt * u),
  fill: accent.transparentize(88%),
  stroke: (0.9pt * u) + accent.transparentize(52%),
  align(
    center + horizon,
    text(font: mono, size: 8.5pt * u, weight: 600, tracking: 0.6pt * u, fill: fg, label),
  ),
)

#let chips(r, accent, u: 1.0) = {
  for m in r.mods {
    cap(upper(m), accent, u: u, w: 46pt * u)
    h(5pt * u)
    text(size: 9pt * u, fill: fg-mute, "+")
    h(5pt * u)
  }
  cap(upper(r.key), accent, u: u)
}

#let tile(code, accent, size: 38pt) = box(
  width: size,
  height: size,
  radius: size * 0.24,
  fill: gradient.linear(
    accent.transparentize(72%),
    accent.transparentize(92%),
    angle: 145deg,
  ),
  stroke: (size * 0.026) + accent.transparentize(55%),
  align(
    center + horizon,
    text(
      font: icon-font,
      size: size * 0.47,
      fill: accent,
      top-edge: "bounds",
      bottom-edge: "bounds",
      str.from-unicode(code),
    ),
  ),
)


#let card(c, u: 1.0, h: auto) = {
  let accent = rgb(c.accent)

  let head = block(
    width: 100%,
    inset: (x: 17pt * u, y: 13pt * u),
    fill: gradient.linear(
      accent.transparentize(84%),
      accent.transparentize(100%),
      angle: 180deg,
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 12pt * u,
      align: horizon,
      tile(c.icon, accent, size: 38pt * u),
      {
        text(size: 15pt * u, weight: 800, tracking: 0.8pt * u, fill: accent, upper(c.label))
        linebreak()
        v(2pt * u)
        text(size: 9pt * u, fill: fg-dim, c.subtitle)
      },
    ),
  )

  let body = block(
    width: 100%,
    inset: (x: 17pt * u, y: 15pt * u),
    grid(
      columns: (auto, 1fr),
      column-gutter: 16pt * u,
      row-gutter: 8pt * u,
      align: (left + horizon, left + horizon),
      ..c
        .rows
        .map(r => (chips(r, accent, u: u), text(size: 10pt * u, r.title)))
        .flatten(),
    ),
  )

  // `align(top + ...)` is load-bearing: the page centres the card grid, and
  // that alignment would otherwise propagate in and centre each card's
  // content, pushing short cards' headers down.
  block(
    width: 100%,
    height: h,
    radius: 13pt,
    fill: panel,
    stroke: 1.1pt + accent.transparentize(58%),
    clip: true,
    align(top + left, stack(
      dir: ttb,
      head,
      line(length: 100%, stroke: 1pt + accent.transparentize(60%)),
      body,
    )),
  )
}

