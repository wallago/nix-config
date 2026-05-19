{ self, ... }:
{
  flake.nixosModules.compositor = {
    imports = [
      self.nixosModules.niri
    ];
  };

  flake.homeModules.compositor = {
    imports = [
      self.homeModules.niri
      self.homeModules.niriFloatSticky
    ];

    home.file.".local/share/cheatsheets/compositor.md".source = ./cheatsheet.md;
  };
}
