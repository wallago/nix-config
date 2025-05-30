{ lib, pkgs, }:
let grimblast = lib.getExe pkgs.grimblast;
in [
  "SUPERSHIFT, p, exec,${grimblast} --notify --freeze copy area"
  "SUPERSHIFTALT, p, exec,${grimblast} --notify --freeze copy output"
]
