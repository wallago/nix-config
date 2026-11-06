{ self, ... }:
{
  flake.nixosModules.gaming = {
    imports = [
      self.nixosModules.gamemode
      self.nixosModules.steam
      self.nixosModules.dofus
    ];
  };

  flake.homeModules.gaming =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.mangohud
        self.homeModules.dofus
      ];

      home.packages = [
        pkgs.protontricks
      ];
    };
}
