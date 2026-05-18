{ self, ... }:
{
  flake.nixosModules.desktopShell = {
    imports = [ self.nixosModules.dms ];
  };

  flake.homeModules.desktopShell = {
    imports = [ self.homeModules.dms ];
  };
}
