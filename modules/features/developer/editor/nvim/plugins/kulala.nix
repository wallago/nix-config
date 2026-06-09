{
  flake.homeModules.nvimPluginKulala =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = kulala-nvim;
          config = ''
            require("kulala").setup({
               global_keymaps = true,
               global_keymaps_prefix = "<leader>R",
               kulala_keymaps_prefix = "",
            })
          '';
        }
      ];
    };
}
