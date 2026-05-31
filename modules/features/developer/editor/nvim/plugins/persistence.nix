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

            -- sessions automatically on exit
            vim.api.nvim_create_autocmd("User", {
              pattern = "PersistenceLoadPost",
              callback = function()
                vim.notify("Session loaded!")
              end,
            })

            -- session automatically loaded at startup
            vim.api.nvim_create_autocmd("VimEnter", {
              callback = function()
                if vim.fn.argc() == 0 then
                  require("persistence").load()
                end
              end,
              nested = true,
            })
          '';
        }
      ];
    };
}
