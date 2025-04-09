{
  lib,
  config,
  pkgs,
  outputs,
  ...
}:
let
  getHostname = x: lib.last (lib.splitString "@" x);
  remoteColorschemes = lib.mapAttrs' (n: v: {
    name = getHostname n;
    value = v.config.colorscheme.rawColorscheme.colors.${config.colorscheme.mode};
  }) outputs.homeConfigurations;
  rgb = color: "rgb(${lib.removePrefix "#" color})";
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
in
{
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
      misc = import ./misc.nix;
      windowrulev2 = import ./windowrulev2.nix { inherit lib remoteColorschemes rgba; };
      layerrule = import ./layerrule.nix;
      decoration = import ./decoration;
      animations = import ./animations;
      exec = import ./exec.nix { inherit pkgs config; };
      monitor = import ./monitor.nix { inherit config; };
      workspace = import ./workspace.nix { inherit config lib; };
      bind = import ./keybindings { inherit config lib pkgs; };
    };
  };
}
