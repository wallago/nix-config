{ self, ... }:
{
  flake.homeModules.nvim = {
    imports = [
      self.homeModules.nvimBinds
      self.homeModules.nvimPluginWhichKey
      self.homeModules.nvimPluginCatppuccin
      self.homeModules.nvimPluginOil
      self.homeModules.nvimPluginLsp
      self.homeModules.nvimPluginConform
    ];

    programs.neovim = {
      enable = true;
      viAlias = true;
      defaultEditor = true;
      waylandSupport = true;
    };
  };
}
