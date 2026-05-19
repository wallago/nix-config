{ self, ... }:
{
  flake.homeModules.editor = {
    imports = [
      self.homeModules.nvim
    ];

    home.file.".local/share/cheatsheets/editor.md".source = ./cheatsheet.md;
  };
}
