{
  flake.nixosModules.rtkit = {
    security.rtkit.enable = true;
  };
}
