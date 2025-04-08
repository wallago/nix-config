{ pkgs, config }:
[
  "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill"
]
