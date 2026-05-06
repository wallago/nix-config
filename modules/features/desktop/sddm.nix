{
  flake.nixosModules.sddm = {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    environment.persistence."/persist" = {
      directories = [
        "/var/lib/sddm"
      ];
    };
  };
}
