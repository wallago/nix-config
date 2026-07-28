{
  flake.homeModules.nvimPluginLualine =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = lualine-nvim;
          config = builtins.readFile ./setup.lua;
        }
      ];
    };
}
