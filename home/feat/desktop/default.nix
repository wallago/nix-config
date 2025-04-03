{ ... }:
{
  imports = [
    ./hyprland
    ./kitty.nix # --> The fast, feature-rich, GPU based terminal emulator
    ./rofi.nix # ---> Window switcher, run dialog and dmenu replacement
    ./waybar.nix # -> Highly customizable Wayland bar for Sway and Wlroots based compositors
    ./mako.nix # ---> Lightweight Wayland notification daemon
  ];
}
