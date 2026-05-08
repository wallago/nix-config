{
  flake.homeModules.nvimPluginTelescope =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = telescope-nvim;
          config = ''
            require("telescope").setup({
              defaults = {
                mappings = {
                  i = {
                    ["<C-e>"] = require("telescope.actions").move_selection_next,
                    ["<C-i>"] = require("telescope.actions").move_selection_previous,
                  },
                },
              },
            })
          '';
        }
        nvim-web-devicons
        telescope-fzf-native-nvim
      ];
      home.packages = with pkgs; [
        ripgrep
        fd
      ];
    };
}
