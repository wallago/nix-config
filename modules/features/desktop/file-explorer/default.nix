{ self, ... }:
{
  flake.nixosModules.fileExplorer = {
    imports = [
      self.nixosModules.nautilus
    ];
  };
}
