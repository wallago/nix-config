{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ nvim-lspconfig ];
  config = ''
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })

    local lspconfig = require("lspconfig")

    lspconfig.rust_analyzer.setup({
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true, -- analyze all Cargo features
            loadOutDirsFromCheck = true, -- improve proc-macro support and performance
          },
          checkOnSave = {
            command = "clippy", -- use Clippy for more thorough diagnostics
            extraArgs = { "--all", "--all-targets" },
          },
          inlayHints = {
            enable = true, -- show inlay type hints for better readability
          },
          diagnostics = {
            enable = true,
          },
          assist = {
            emitMustUse = true, -- insert #[must_use] in generated code where appropriate
          },
          rustfmt = {
            extraArgs = { "+nightly" }, -- use nightly rustfmt if needed
          },
          memoryLimit = 4096, -- increase memory limit for large projects
        },
      },
    })

    lspconfig.nixd.setup({
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
  '';
  deps = with pkgs; [ rust-analyzer nixd nixfmt-classic ];
}
