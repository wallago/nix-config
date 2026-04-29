{
  flake.nixosModules.sddm = {
    services.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
