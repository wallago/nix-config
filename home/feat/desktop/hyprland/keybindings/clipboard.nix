{
  lib,
  config,
}:
let
  cliphist = lib.getExe config.services.cliphist.package;
  wofi = lib.getExe config.programs.wofi.package;
in
lib.optionals (config.services.cliphist.enable && config.programs.wofi.enable) [
  ''SUPER,c,exec,selected=$(${cliphist} list | ${wofi} -S dmenu) && echo "$selected" | ${cliphist} decode | wl-copy''
]
