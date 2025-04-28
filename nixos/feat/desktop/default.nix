{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [ wayland xwayland wl-clipboard ];
}
