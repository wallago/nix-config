{ lib, config, pkgs, ... }:
let rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      general = import ./general.nix { inherit config rgba; };
      cursor = import ./cursor.nix;
      group = import ./group.nix { inherit config rgba; };
      binds = import ./binds.nix;
      input = import ./input.nix;
      dwindle = import ./dwindle.nix;
      misc = import ./misc.nix { inherit config lib; };
      windowrulev2 = import ./windowrulev2.nix;
      layerrule = import ./layerrule.nix;
      decoration = import ./decoration;
      animations = import ./animations;
      monitor = import ./monitor.nix { inherit config; };
      workspace = import ./workspace.nix { inherit config lib; };
      bind = import ./keybindings { inherit config lib pkgs; };
      bindm = [ "SUPER,mouse:272,movewindow" "SUPER,mouse:273,resizewindow" ];
    };
  };
}
