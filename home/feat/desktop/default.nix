{ pkgs, ... }: {
  imports = [
    ./hyprland
    ./firefox.nix
    ./waybar
    ./ghostty.nix
    ./cliphist.nix
    ./gammastep.nix
    ./imv.nix
    ./mako.nix
    ./zathura.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  xdg = {
    mimeApps.enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    };
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };

  home.packages = with pkgs; [ wf-recorder wl-clipboard ];
}
