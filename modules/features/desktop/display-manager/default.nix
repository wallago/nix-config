{ self, ... }:
{
  flake.nixosModules.displayManager = {
    imports = [
      self.nixosModules.sddm
      self.nixosModules.qylock
    ];
  };
}
