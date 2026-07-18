{
  flake.homeModules.nvimPluginScope =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = scope-nvim;
          config = ''
            require("scope").setup({})

            vim.api.nvim_set_keymap("n", "<leader>]t", "<cmd>tabnext<CR>", { desc = "Next Tab" })
            vim.api.nvim_set_keymap("n", "<leader>[T", "<cmd>tabNext<CR>", { desc = "Previous Tab" })
          '';
        }
      ];
    };
}
