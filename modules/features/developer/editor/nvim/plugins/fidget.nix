{
  flake.homeModules.nvimPluginFidget =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = fidget-nvim;
          config = ''
            require("fidget").setup({
              notification = {
                window = {
                  winblend = 0,
                },
              }
            })
          '';
        }
      ];
    };
}
