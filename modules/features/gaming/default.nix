{ self, ... }:
{
  flake.nixosModules.gaming = {
    imports = [
      self.nixosModules.gamemode
      self.nixosModules.steam
      self.nixosModules.gamescope
    ];
  };

  flake.homeModules.gaming =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.mangohud
      ];

      home.packages = [
        pkgs.protontricks
      ];
    };
}
