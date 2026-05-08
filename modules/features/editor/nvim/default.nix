{ self, ... }:
{
  flake.homeModules.nvim = {
    imports = [
      self.homeModules.nvimBinds
      self.homeModules.nvimPluginWhichKey
      self.homeModules.nvimPluginCatppuccin
    ];

    programs.neovim = {
      enable = true;
      viAlias = true;
      defaultEditor = true;
      waylandSupport = true;
    };
  };
}
