{
  flake.homeModules.nvimPluginLsp =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-lspconfig;
          config = ''
            vim.lsp.inlay_hint.enable(true)
            vim.lsp.config("nixd", {
              cmd = { "nixd" },
              settings = {
                nixd = {
                  nixpkgs = {
                    expr = "import <nixpkgs> { }",
                  },
                  formatting = {
                    command = { "nixfmt" },
                  },
                },
              },
            })
            vim.lsp.enable("nixd")

            vim.diagnostic.config({
              virtual_lines = { current_line = true },
              signs = true,
              underline = true,
              severity_sort = true,
              update_in_insert = false,
              float = { border = "rounded", source = true },
            })

            map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: go to definition" })
            map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: go to declaration" })
            map("n", "gr", vim.lsp.buf.references, { desc = "LSP: references" })
            map("n", "gI", vim.lsp.buf.implementation, { desc = "LSP: implementation" })
            map("n", "gh", vim.lsp.buf.hover, { desc = "LSP: hover" })
            map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: rename" })
            map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: code action" })

            map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
            map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

            map("n", "<leader>fs", vim.lsp.buf.document_symbol, { desc = "LSP: file symbols" })
            map("n", "<leader>fS", vim.lsp.buf.workspace_symbol, { desc = "LSP: workspace symbols" })
          '';
        }
      ];

      home.packages = with pkgs; [
        nixd
        nixfmt
      ];
    };
}
