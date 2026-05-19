{
  flake.homeModules.nvimPluginTrouble =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = trouble-nvim;
          config = ''
            require("trouble").setup({
              focus = true,   -- jump into the list when it opens
              keys = {
                e = "next",   -- down
                i = "prev",   -- up
              },
            })

            map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",
              { desc = "Trouble: diagnostics (workspace)" })
            map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
              { desc = "Trouble: diagnostics (current buffer)" })
            map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",
              { desc = "Trouble: symbols (outline)" })
            map("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
              { desc = "Trouble: LSP references/defs" })
            map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>",
              { desc = "Trouble: location list" })
            map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",
              { desc = "Trouble: quickfix list" })
          '';
        }
      ];
    };
}
