{ pkgs, config }:
[
  "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill"
  "hyprctl setcursor ${config.gtk.cursorTheme.name} ${toString config.gtk.cursorTheme.size}"
]
