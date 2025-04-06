{
  lib,
  remoteColorschemes,
  rgba,
}:
let
  picture_in_picture = "title:Picture-in-Picture, class:firefox";
  rofi = "class:^(Rofi)$";
in
[
  "float, ${picture_in_picture}"
  "move 73.5% 8%, ${picture_in_picture}"
  "size 25% 25%, ${picture_in_picture}"
  "pin, ${picture_in_picture}"
  "noinitialfocus, ${picture_in_picture}"
  "noborder, ${picture_in_picture}"
  "nofocus, ${picture_in_picture}"

  "float, ${rofi}"
  "pin, ${rofi}"
  "stayfocused, ${rofi}"
  "noanim, ${rofi}"
  "noborder, ${rofi}"
  "norounding, ${rofi}"
  "dimaround, ${rofi}"
]
++ (lib.mapAttrsToList (
  name: colors:
  "bordercolor ${rgba colors.primary "aa"} ${rgba colors.primary_container "aa"}, title:\\[${name}\\].*"
) remoteColorschemes)
