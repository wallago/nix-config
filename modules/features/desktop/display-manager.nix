{ self, ... }:
{
  flake.nixosModules.displayManager = {
    imports = [
      self.nixosModules.sddm
    ];
  };
}
