{
  flake.homeModules.nvimPluginScope =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = scope-nvim;
          config = ''
            require("scope").setup({})
          '';
        }
      ];
    };
}
