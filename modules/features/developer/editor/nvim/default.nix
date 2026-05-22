{ self, ... }:
{
  flake.homeModules.nvim = {
    imports = [
      self.homeModules.nvimBinds
      self.homeModules.nvimOptions
      self.homeModules.nvimPluginsCore
      self.homeModules.nvimPluginsOptions
      self.homeModules.nvimPluginsCodes
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
      self.homeModules.nvimPluginTelescope
      self.homeModules.nvimPluginLualine
      self.homeModules.nvimPluginWhichKey
      self.homeModules.nvimPluginYanky
      self.homeModules.nvimPluginPersistence
      self.homeModules.nvimPluginMarks
    ];
  };

  flake.homeModules.nvimPluginsCodes = {
    imports = [
      self.homeModules.nvimPluginConform
      self.homeModules.nvimPluginTreesitter
      self.homeModules.nvimPluginLsp
      self.homeModules.nvimPluginRustacean
      self.homeModules.nvimPluginDap
      self.homeModules.nvimPluginFidget
      self.homeModules.nvimPluginTrouble
      self.homeModules.nvimPluginBlink
      self.homeModules.nvimPluginAutopairs
    ];
  };

  flake.homeModules.nvimPluginsOptions = {
    imports = [
      self.homeModules.nvimPluginCatppuccin
      self.homeModules.nvimPluginMarkdown
      self.homeModules.nvimPluginTabs
    ];
  };
}
