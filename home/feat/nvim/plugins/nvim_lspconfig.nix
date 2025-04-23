{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ nvim-lspconfig ];
  config = ''
    vim.lsp.inlay_hint.enable(true)

    local lspconfig = require("lspconfig")
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
  deps = with pkgs; [ nixd nixfmt-classic ];
}
