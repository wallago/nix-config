{ self, ... }:
{
  flake.nixosModules.developer = {
    imports = [
      self.nixosModules.netrc
      self.nixosModules.direnv
      self.nixosModules.nix-ld

      self.nixosModules.kicad
    ];
  };

  flake.homeModules.developer = {
    imports = [
      self.homeModules.editor
      self.homeModules.git
      self.homeModules.jujutsu
    ];
  };
}
