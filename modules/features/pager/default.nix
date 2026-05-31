{ self, ... }:
{
  flake.nixosModules.pager = {
    imports = [
      self.nixosModules.less
    ];
  };

  flake.homeModules.pager = {
    home.file.".local/share/cheatsheets/pager.md".source = ./cheatsheet.md;
  };
}
