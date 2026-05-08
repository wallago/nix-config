{ self, ... }:
{
  flake.homeModules.nvim = {
    imports = [
      self.homeModules.nvimBinds
      self.homeModules.nvimPluginsCore
      self.homeModules.nvimPluginsOpt
    ];

    programs.neovim = {
      enable = true;
      viAlias = true;
      defaultEditor = true;
      waylandSupport = true;
    };
  };

  flake.homeModules.nvimPluginsCore = {
    imports = [
      self.homeModules.nvimPluginOil
      self.homeModules.nvimPluginLsp
      self.homeModules.nvimPluginConform
      self.homeModules.nvimPluginTreesitter
      self.homeModules.nvimPluginTelescope
      self.homeModules.nvimPluginLualine
      self.homeModules.nvimPluginWhichKey
    ];
  };

  flake.homeModules.nvimPluginsOpt = {
    imports = [
      self.homeModules.nvimPluginCatppuccin
    ];
  };
}
