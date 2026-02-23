{ config, ... }:
let
  waybarSpace = let
    inherit (config.wayland.windowManager.hyprland.settings.general)
      gaps_in gaps_out;
    inherit (config.programs.waybar.settings.primary) position height width;
    gap = gaps_out - gaps_in;
  in {
    top = if (position == "top") then height + gap else 0;
    bottom = if (position == "bottom") then height + gap else 0;
    left = if (position == "left") then width + gap else 0;
    right = if (position == "right") then width + gap else 0;
  };
in [
  ",addreserved,${toString waybarSpace.top},${toString waybarSpace.bottom},${
    toString waybarSpace.left
  },${toString waybarSpace.right}"
] ++ (map (m:
  "${m.name},${
    if m.enabled then
      "${toString m.width}x${toString m.height}@${
        toString m.refreshRate
      },${m.position},${toString m.scale}"
    else
      "disable"
  }") (config.monitors))
