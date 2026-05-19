{
  flake.homeModules.nvimPluginPersistence =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = persistence-nvim;
          config = ''
            require("persistence").setup({})

            local map = vim.keymap.set
            map("n", "<leader>qs", function() require("persistence").load() end,
              { desc = "Restore session for cwd" })
            map("n", "<leader>ql", function() require("persistence").load({ last = true }) end,
              { desc = "Restore last session" })
            map("n", "<leader>qd", function() require("persistence").stop() end,
              { desc = "Don't save current session" })
          '';
        }
      ];
    };
}
