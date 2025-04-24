{
  lib,
  pkgs,
}:
let
  grimblast = lib.getExe pkgs.grimblast;
in
[
  ",Print,exec,${grimblast} --notify --freeze copy area"
  "SHIFT,Print,exec,${grimblast} --notify --freeze copy output"
]
