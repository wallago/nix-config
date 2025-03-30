{ pkgs, ... }:
{
  imports = [
    ./common/firefox.nix
  ];

  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wayland # ------> Core Wayland protocol libraries.
    xwayland # -----> Required if you want to run X11 apps under Wayland.
    wl-clipboard # -> Clipboard utilities for Wayland (copy/paste support).
  ];

  programs.hyprland.enable = true;

  environment.etc = {
    "hypr/hyprland.conf".source = ./hyprland.conf;
    "hypr/windowrule.conf".source = ./windowrule.conf;
    "hypr/keybindings.conf".source = ./keybindings.conf;
  };
}
