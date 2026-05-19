{
  flake.homeModules.nvimPluginRustacean =
    { pkgs, ... }:
    let
      lldb = pkgs.vscode-extensions.vadimcn.vscode-lldb;
      codelldbPath = "${lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
      liblldbPath = "${lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.so";
    in
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = rustaceanvim;
          config = ''
            vim.g.rustaceanvim = {
              server = {
                on_attach = function(_, bufnr)
                  local function rmap(lhs, action, desc)
                    vim.keymap.set("n", lhs, function()
                      vim.cmd.RustLsp(action)
                    end, { buffer = bufnr, desc = desc })
                  end

                  -- Rust-aware overrides of your generic LSP binds (buffer-local)
                  rmap("gh", { "hover", "actions" }, "Rust: hover actions")
                  vim.keymap.set("n", "<leader>ca", function()
                    vim.cmd.RustLsp("codeAction")
                  end, { buffer = bufnr, desc = "Rust: code action" })

                  -- <leader>r = Rust group
                  rmap("<leader>rr", "runnables",    "Rust: runnables")
                  rmap("<leader>rt", "testables",    "Rust: testables")
                  rmap("<leader>rd", "debuggables",  "Rust: debuggables")
                  rmap("<leader>rm", "expandMacro",  "Rust: expand macro")
                  rmap("<leader>re", "explainError", "Rust: explain error")
                  rmap("<leader>rc", "openCargo",    "Rust: open Cargo.toml")
                  rmap("<leader>rp", "parentModule", "Rust: parent module")
                  rmap("<leader>rD", "openDocs",     "Rust: open docs.rs")
                end,
                default_settings = {
                  ["rust-analyzer"] = {
                    cargo = { allFeatures = true },
                    checkOnSave = true,
                    check = { command = "clippy" },
                    procMacro = { enable = true },
                    diagnostics = {
                      enable = true,
                      experimental = {
                        enable = true,
                      },
                    },
                  },
                },
              },
              dap = {
                adapter = require("rustaceanvim.config").get_codelldb_adapter(
                  "${codelldbPath}", "${liblldbPath}"
                ),
              },
            }
          '';
        }
      ];
    };
}
