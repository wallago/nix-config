{ lib, pkgs, }:
let
  pactl = lib.getExe' pkgs.pulseaudio "pactl";
  output-volume = "swayosd-client --output-volume +0";
  input-volume = "swayosd-client --input-volume +0";
in [
  ",XF86AudioRaiseVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ +5%; ${output-volume}"
  ",XF86AudioLowerVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ -5%; ${output-volume}"
  ",XF86AudioMicMute,exec,${pactl} set-sink-mute @DEFAULT_SOURCE@ toggle; ${output-volume}"
  "SHIFT,XF86AudioRaiseVolume,exec,${pactl} set-source-volume @DEFAULT_SOURCE@ +5%; ${input-volume}"
  "SHIFT,XF86AudioLowerVolume,exec,${pactl} set-source-volume @DEFAULT_SOURCE@ -5%; ${input-volume}"
  "SHIFT,XF86AudioMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle; ${input-volume}"
]
