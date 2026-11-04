{ self, ... }:
{
  flake.nixosModules.developer = { pkgs, ... }: {
    imports = [
      self.nixosModules.direnv
      self.nixosModules.nix-ld
      self.nixosModules.devApps
      self.nixosModules.probe-rs
    ];

    # For claude access to chromium
    environment.systemPackages = with pkgs; [ chromium ];
  };

  flake.homeModules.developer = {
    imports = [
      self.homeModules.editor
      self.homeModules.gh
      self.homeModules.praline
      self.homeModules.versionControlManager
    ];

    preferences.developer.enable = true;
  };
}
