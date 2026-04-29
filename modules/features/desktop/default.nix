{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.displayManager
      self.nixosModules.qylock
      self.nixosModules.fonts
    ];
  };
}
