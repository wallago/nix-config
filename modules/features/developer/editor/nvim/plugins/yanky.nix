{
  flake.homeModules.nvimPluginYanky =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = yanky-nvim;
          config = ''
            require("yanky").setup({})
          '';
        }
      ];
    };
}
