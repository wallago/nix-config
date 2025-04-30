{ lib, pkgs, }:
let backlight = lib.getExe pkgs.brightnessctl;
in [
  ",XF86MonBrightnessUp,exec,${backlight} set +5%"
  ",XF86MonBrightnessDown,exec,${backlight} set 5%-"
]
