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
                  options = {
                    nixos = {
                      expr = "(builtins.head (builtins.attrValues (builtins.getFlake (toString ./.)).nixosConfigurations)).options",
                    },
                    ["home-manager"] = {
                      expr = "(builtins.head (builtins.attrValues (builtins.getFlake (toString ./.)).nixosConfigurations)).options.home-manager.users.type.getSubOptions []",
                    },
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
            map({ "n", "v" }, "ga", vim.lsp.buf.code_action, { desc = "LSP: code action" })

            map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
            map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

            map("n", "<leader>fs", vim.lsp.buf.document_symbol, { desc = "LSP: file symbols" })
            map("n", "<leader>fS", vim.lsp.buf.workspace_symbol, { desc = "LSP: workspace symbols" })

            map("n", "<leader>fo", function()
              local word = vim.fn.expand("<cWORD>"):gsub("[=;{}]", "")
              local res = vim.system({ "manix", word }, { text = true }):wait()
              local out = (res.stdout or "")
              if out == "" then out = "no match for: " .. word end
              local lines = vim.split(out, "\n")

              local buf = vim.api.nvim_create_buf(false, true)        -- scratch buffer
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
              vim.bo[buf].modifiable = false
              vim.bo[buf].filetype = "markdown"

              local width  = math.min(100, vim.o.columns - 4)
              local height = math.min(#lines, vim.o.lines - 6)
              local win = vim.api.nvim_open_win(buf, true, {          -- `true` = enter/focus it
                relative = "editor",
                row = math.floor((vim.o.lines - height) / 2),
                col = math.floor((vim.o.columns - width) / 2),
                width = width,
                height = height,
                border = "rounded",
                style = "minimal",
              })
              for _, k in ipairs({ "q", "<Esc>" }) do
                vim.keymap.set("n", k, function() vim.api.nvim_win_close(win, true) end, { buffer = buf })
              end
            end, { desc = "Manix: option docs under cursor" })
          '';
        }
      ];

      home.packages = with pkgs; [
        nixd
        nixfmt
        manix
      ];
    };
}
