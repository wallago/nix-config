{ lib, config, }:
let
  tofidrun = lib.getExe' config.programs.tofi.package "tofi-drun";
  tofirun = lib.getExe' config.programs.tofi.package "tofi-run";
  tofi = lib.getExe' config.programs.tofi.package "tofi";
in lib.optionals config.programs.tofi.enable [
  "SUPER,x,exec,${tofidrun} --drun-launch=true"
  "SUPER,d,exec,${tofirun}"
  "SUPER,t,exec,specialisation=$(specialisation | ${tofi})"
]
