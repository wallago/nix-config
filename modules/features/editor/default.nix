{ self, ... }:
{
  flake.homeModules.editor = {
    imports = [
      self.homeModules.nvim
    ];
  };
}
