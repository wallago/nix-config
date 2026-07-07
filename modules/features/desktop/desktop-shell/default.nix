{ self, ... }:
{
  flake.nixosModules.desktopShell = {
    imports = [ self.nixosModules.dms ];
  };
}
