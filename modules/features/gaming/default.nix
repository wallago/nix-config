{ self, ... }:
{
  flake.nixosModules.gaming = {
    imports = [
      self.nixosModules.gamemode
    ];
  };

  flake.homeModules.gaming =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        steam
      ];
    };
}
