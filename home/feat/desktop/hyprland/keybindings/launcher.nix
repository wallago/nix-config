{ lib, config, }:
let wofi = lib.getExe config.programs.wofi.package;
in lib.optionals config.programs.wofi.enable [
  "SUPER,x,exec,${wofi} -S drun -x 10 -y 10 -W 25% -H 60%"
  "SUPER,s,exec,specialisation $(specialisation | ${wofi} -S dmenu)"
  "SUPER,d,exec,${wofi} -S run"
]
