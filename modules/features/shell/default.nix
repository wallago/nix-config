{ self, ... }:
{
  flake.nixosModules.shell = {
    imports = [
      self.nixosModules.fish
      self.nixosModules.atuinClient
    ];
  };

  flake.homeModules.shell = {
    imports = [
      self.homeModules.fish
      self.homeModules.starship
    ];
  };
}
