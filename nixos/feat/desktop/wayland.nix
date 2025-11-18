{ pkgs, config, lib, ... }: {
  services = {
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
      enable = true;
      # Export user sessions to system
      sessionPackages = lib.flatten
        (lib.mapAttrsToList (_: v: v.home.exportedSessionPackages)
          config.home-manager.users);
    };
  };

  environment.systemPackages = with pkgs; [ wayland xwayland ];
}
