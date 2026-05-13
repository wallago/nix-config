{ self, ... }:
{
  flake.nixosModules.browser = {
    imports = [ self.nixosModules.zen ];
  };

  flake.homeModules.browser = {
    imports = [ self.homeModules.zen ];
  };
}
