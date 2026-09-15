// Geometry, palette and document setup shared by every cheatsheet page.

// ── geometry ─────────────────────────────────────────────────────────
#let page-w = 1920pt
#let page-h = 1080pt
#let pad = 34pt
#let gut = 22pt
#let cols = 3
#let band = 18pt
#let col-w = (page-w - 2 * pad - (cols - 1) * gut) / cols

// ── palette ──────────────────────────────────────────────────────────
#let bg = rgb("#070a11")
#let panel = rgb("#0d1320")
#let fg = rgb("#e7eef6")
#let fg-dim = rgb("#8593a6")
#let fg-mute = rgb("#5a6779")
#let hair = rgb("#1a2332")

#let mono = "FiraCode Nerd Font"
#let icon-font = "FiraCode Nerd Font Propo"

// Metric scale for the header/footer bands.
#let chrome = 1.45

#let conf(doc) = {
  set page(width: page-w, height: page-h, margin: pad, fill: bg)
  set text(font: "Noto Sans", fill: fg, size: 10pt)
  doc
}
