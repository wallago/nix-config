{ colorscheme }:
let
  c = colorscheme.colors;
in
{
  fg = c.on_surface_variant;
  bg = c.surface_variant;
  black = c.surface;
  red = c.on_primary;
  green = c.green;
  yellow = c.yellow;
  blue = c.blue;
  magenta = c.magenta;
  cyan = c.cyan;
  white = c.on_surface;
  orange = c.orange;
}
