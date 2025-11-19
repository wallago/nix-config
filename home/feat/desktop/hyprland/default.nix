{ lib, config, pkgs, ... }:
let rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
in {

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      # Same as default, but stop graphical-session too
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
      variables = [
        "DISPLAY"
        "HYPRLAND_INSTANCE_SIGNATURE"
        "WAYLAND_DISPLAY"
        "XDG_CURRENT_DESKTOP"
      ];
    };
    package = config.lib.nixGL.wrap
      (pkgs.hyprland.override { wrapRuntimeDeps = false; });
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

  xdg.portal = {
    extraPortals = [
      (pkgs.xdg-desktop-portal-hyprland.override {
        hyprland = config.wayland.windowManager.hyprland.package;
      })
    ];
    config.hyprland = { default = [ "hyprland" "gtk" ]; };
  };

  home.packages = with pkgs; [ hyprland-qtutils ];

  home.exportedSessionPackages =
    [ config.wayland.windowManager.hyprland.package ];
}
