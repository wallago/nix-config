{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.fonts
    ];
  };
}
