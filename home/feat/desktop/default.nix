{ pkgs, ... }: {
  imports = [
    ./hyprland # -- check deps for bindings
    ./firefox.nix # -> Browser
    ./waybar # ------> Status bar
    ./ghostty.nix # -> Terminal emulator

    # ./wofi.nix # ----> Launcher and window switcher
    # ./mako.nix # ----> Lightweight notification daemon
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

  # home.packages = with pkgs;
  #   [
  #     # grimblast # ----> Helper for screenshots within Hyprland, based on grimshot.
  #     # pulseaudio # ---> Sound server for POSIX and Win32 systems -- WIP
  #     # swaylock # -----> Screen locker for Wayland
  #     # pass-wofi # ----> Script to make wofi work with password-store
  #     # cliphist # -----> Wayland clipboard manager
  #   ];
}
