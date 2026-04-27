{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    nvim-ufo
    promise-async
  ];
  config = ''
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }  -- LSP first, fallback to indent
      end,
    })
  '';
}
