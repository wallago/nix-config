{
  flake.homeModules.nvimPluginCatppuccin =
    { pkgs, ... }:
    {
      programs.neovim.plugins = [
        {
          plugin = pkgs.vimPlugins.catppuccin-nvim;
          config = builtins.readFile ./setup.lua;
        }
      ];
    };
}
