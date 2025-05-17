{ lib, config, }:
let hyprlock = lib.getExe config.programs.hyprlock.package;
in lib.optionals config.programs.hyprlock.enable [
  "SUPER,backspace,exec,${hyprlock}"
  "SUPER,XF86Calculator,exec,${hyprlock}"
]
