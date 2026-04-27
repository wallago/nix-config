{ lib, config, }:
let
  cliphist = lib.getExe config.services.cliphist.package;
  tofi = lib.getExe' config.programs.tofi.package "tofi";
in lib.optionals
(config.services.cliphist.enable && config.programs.tofi.enable)
[ "SUPER,c,exec,${cliphist} list | ${tofi} | ${cliphist} decode | wl-copy" ]
