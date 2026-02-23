{ pkgs, lib }:
let backlight = lib.getExe pkgs.brightnessctl;
in [
  ",XF86MonBrightnessUp,exec,${backlight} set +5%; swayosd-client --brightness +0"
  ",XF86MonBrightnessDown,exec,${backlight} set 5%-; swayosd-client --brightness +0"
]
