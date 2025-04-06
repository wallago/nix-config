{ pkgs, ... }:
{
  imports = [
    ./hyprland
    ./kitty.nix # ---> The fast, feature-rich, GPU based terminal emulator
    ./rofi.nix # ----> Window switcher, run dialog and dmenu replacement
    ./waybar.nix # --> Highly customizable Wayland bar for Sway and Wlroots based compositors
    ./mako.nix # ----> Lightweight Wayland notification daemon
    ./firefox.nix # -> Browser
  ];

  home.packages = with pkgs; [
    grimblast # ----> Helper for screenshots within Hyprland, based on grimshot.
    pulseaudio # ---> Sound server for POSIX and Win32 systems
    handlr-regex # -> Manage your default applications
    swaylock # -----> Screen locker for Wayland
    pass-wofi # ----> Script to make wofi work with password-store
    cliphist # -----> Wayland clipboard manager
  ];
}
