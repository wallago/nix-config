{ self, ... }:
{
  flake.nixosModules.devApps = {
    imports = [
      self.nixosModules.bambulab
      self.nixosModules.kicad
    ];
  };
}
