{
  flake.homeModules.nvimPluginTips =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = neovim-tips;
          config = ''
             require("neovim_tips").setup {
              user_file = vim.fn.expand("~/sync-nvim/neovim_tips/user_tips.md"),
              user_tip_prefix = "[User] ",  -- Prefix for user tips
              warn_on_conflicts = true,     -- Warn about title conflicts
              daily_tip = 2,                -- Daily tip: 0=off, 1=once per day, 2=every startup
            }

            vim.api.nvim_set_keymap("n", "<leader>no", "<cmd>NeovimTips<CR>", { desc = "Tips" })
            vim.api.nvim_set_keymap("n", "<leader>no", "<cmd>NeovimTipsBookmarks<CR>", { desc = "Bookmarked tips" })
            vim.api.nvim_set_keymap("n", "<leader>ne", "<cmd>NeovimTipsEdit<CR>", { desc = "Edit tip" })
            vim.api.nvim_set_keymap("n", "<leader>ne", "<cmd>NeovimTipsAdd<CR>", { desc = "Add tip" })
            vim.api.nvim_set_keymap("n", "<leader>nh", "<cmd>help neovim-tips<CR>", { desc = "neovim-tips help" })
            vim.api.nvim_set_keymap("n", "<leader>nr", "<cmd>NeovimTipsRandom<CR>", { desc = "Show random tip" })
            vim.api.nvim_set_keymap("n", "<leader>np", "<cmd>NeovimTipsPdf<CR>", { desc = "Open tips PDF" })
          '';
        }
        render-markdown-nvim
        nui-nvim
      ];
    };
}
