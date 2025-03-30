{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
          banner = "go fuck your self";
        };
      };
    };
    ratbagd.enable = true; # DBus daemon to configure input devices
    dbus.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    wayland # ------> Core Wayland protocol libraries.
    xwayland # -----> Required if you want to run X11 apps under Wayland.
    wl-clipboard # -> Clipboard utilities for Wayland (copy/paste support).
  ];
}
