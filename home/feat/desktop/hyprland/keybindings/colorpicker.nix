{ lib, pkgs, }:
let hyprpicker = lib.getExe pkgs.hyprpicker;
in [ "SUPER,P,exec,${hyprpicker}" ]
