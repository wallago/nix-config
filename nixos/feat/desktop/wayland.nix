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

  environment.systemPackages = with pkgs; [ wayland xwayland ];
}
