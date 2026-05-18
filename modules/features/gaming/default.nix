{ self, ... }:
{
  flake.nixosModules.gaming = {
    imports = [
      self.nixosModules.gamemode
      self.nixosModules.steam
      self.nixosModules.gamescope
    ];
  };

  flake.homeModules.gaming = {
    imports = [
      self.homeModules.mangohud
    ];
  };
}
