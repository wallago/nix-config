{
  lib,
  pkgs,
  config,
  ...
}:
let
  playerctl = lib.getExe' config.services.playerctld.package "playerctl";
  playerctld = lib.getExe' config.services.playerctld.package "playerctld";
in
lib.optionals config.services.playerctld.enable [
  ",XF86AudioNext,exec,${playerctl} next"
  ",XF86AudioPrev,exec,${playerctl} previous"
  ",XF86AudioPlay,exec,${playerctl} play-pause"
  ",XF86AudioStop,exec,${playerctl} stop"
  "SHIFT,XF86AudioNext,exec,${playerctld} shift"
  "SHIFT,XF86AudioPrev,exec,${playerctld} unshift"
  "SHIFT,XF86AudioPlay,exec,systemctl --user restart playerctld"
]
