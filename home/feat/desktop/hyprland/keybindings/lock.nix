{
  lib,
  config,
}:
let
  swaylock = lib.getExe config.programs.swaylock.package;
in
lib.optionals config.programs.swaylock.enable [
  "SUPER,backspace,exec,${swaylock} -S --grace 2 --grace-no-mouse"
  "SUPER,XF86Calculator,exec,${swaylock} -S --grace 2 --grace-no-mouse"
]
