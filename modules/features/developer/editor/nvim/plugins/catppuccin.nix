{
  flake.homeModules.nvimPluginCatppuccin =
    { pkgs, ... }:
    {
      programs.neovim.plugins = [
        {
          plugin = pkgs.vimPlugins.catppuccin-nvim;
          config = ''
            vim.cmd.colorscheme "catppuccin-nvim"
          '';
        }
      ];
    };
}
