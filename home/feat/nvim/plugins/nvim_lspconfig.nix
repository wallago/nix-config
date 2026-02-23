{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ nvim-lspconfig ];
  config = ''
    vim.lsp.inlay_hint.enable(true)
    vim.lsp.set_log_level("INFO")
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
  '';
  deps = with pkgs; [
    nixd
    nixfmt
  ];
}
