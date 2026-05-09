{ self, ... }:
{
  flake.nixosModules.developer = {
    imports = [
      self.nixosModules.kicad
    ];
  };

  flake.homeModules.developer = {
    imports = [
      self.homeModules.git
      self.homeModules.jujutsu
    ];
  };
}
