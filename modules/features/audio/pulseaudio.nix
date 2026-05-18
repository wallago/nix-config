{
  flake.nixosModules.pulseaudio = {
    services.pulseaudio.enable = false;
  };
}
