{ self, ... }:
{
  flake.nixosModules.general = {
    imports = [
      self.nixosModules.nix
      self.nixosModules.home-manager
    ];
  };
}
