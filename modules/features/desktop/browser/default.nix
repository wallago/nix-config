{ self, ... }:
{
  flake.homeModules.browser = {
    imports = [ self.homeModules.zen ];

    home.file.".local/share/cheatsheets/browser.md".source = ./cheatsheet.md;
  };
}
