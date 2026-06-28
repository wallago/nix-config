{ self, ... }:
{
  flake.nixosModules.developer = {
    imports = [
      self.nixosModules.direnv
      self.nixosModules.nix-ld

      self.nixosModules.devApps
    ];

    networking.firewall.allowedTCPPorts = [ 3000 ];
  };

  flake.homeModules.developer = {
    imports = [
      self.homeModules.editor
      self.homeModules.versionControlManager
    ];

    preferences.developer.enable = true;
  };
}
