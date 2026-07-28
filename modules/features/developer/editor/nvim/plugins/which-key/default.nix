{
  flake.homeModules.nvimPluginWhichKey =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = which-key-nvim;
          config = builtins.readFile ./setup.lua;
        }
        mini-icons
        nvim-web-devicons
      ];
    };
}
