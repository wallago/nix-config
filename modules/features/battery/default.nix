{
  flake.nixosModules.battery = {
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
  };
}
