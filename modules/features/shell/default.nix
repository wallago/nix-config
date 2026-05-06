{ self, ... }:
{
  flake.nixosModules.shell = {
    imports = [ self.nixosModules.fish ];
  };

  flake.homeModules.shell = {
    imports = [
      self.homeModules.fish
      self.homeModules.starship
    ];
  };
}
