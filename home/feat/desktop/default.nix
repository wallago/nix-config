{ pkgs, config, ... }:
{
  imports = [
    ./hyprland
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./cursor.nix
    ./firefox.nix
    ./discord.nix
    ./dragon.nix
    ./nautilus.nix
    ./waybar
    ./teams.nix
    ./tofi.nix
    ./ghostty.nix
    ./cliphist.nix
    ./wlsunset.nix
    ./imv.nix
    ./mako.nix
    ./zathura.nix
    ./waypipe.nix
    ./swayosd.nix
  ];

  xdg = {
    mimeApps.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };

  # Also sets org.freedesktop.appearance color-scheme
  dconf.settings."org/gnome/desktop/interface".color-scheme =
    if config.colorscheme.mode == "dark" then
      "prefer-dark"
    else if config.colorscheme.mode == "light" then
      "prefer-light"
    else
      "default";

  home.packages = with pkgs; [
    wf-recorder
    wl-clipboard
    libnotify
    handlr-regex
  ];
}
