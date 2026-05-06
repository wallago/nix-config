{
  flake.nixosModules.sddm = {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
