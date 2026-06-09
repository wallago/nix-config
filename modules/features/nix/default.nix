{ self, ... }:
{
  flake.nixosModules.nix = {
    imports = [
      self.nixosModules.nixCore
      self.nixosModules.nixTools
      self.nixosModules.nixOverlays
    ];
  };

}
