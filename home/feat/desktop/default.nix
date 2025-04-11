{ pkgs, ... }:
{
  imports = [
    ./hyprland # -- check deps for bindings
    ./firefox.nix # -> Browser
    ./waybar.nix # --> Status bar -- WIP
    ./alacritty.nix # -- WIP

    # ./kitty.nix # ---> Terminal emulator
    # ./wofi.nix # ----> Launcher and window switcher
    # ./mako.nix # ----> Lightweight notification daemon
  ];

  home.packages = with pkgs; [
    # grimblast # ----> Helper for screenshots within Hyprland, based on grimshot.
    # pulseaudio # ---> Sound server for POSIX and Win32 systems
    # handlr-regex # -> Manage your default applications
    # swaylock # -----> Screen locker for Wayland
    # pass-wofi # ----> Script to make wofi work with password-store
    # cliphist # -----> Wayland clipboard manager
  ];
}
