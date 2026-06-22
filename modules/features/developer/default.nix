{ self, ... }:
{
  flake.nixosModules.developer = {
    imports = [
      self.nixosModules.direnv
      self.nixosModules.nix-ld

      self.nixosModules.devApps
    ];
  };

  flake.homeModules.developer = {
    imports = [
      self.homeModules.editor
      self.homeModules.versionControlManager
    ];

    preferences.developer.enable = true;
  };
}
