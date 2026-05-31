{
  flake.homeModules.nvimPluginLualine =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = lualine-nvim;
          config = ''
            require('lualine').setup({
              options = {
                theme = "catppuccin-mocha",
              },
            })
          '';
        }
      ];
    };
}
