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

    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
    vim.keymap.set("n", "K", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.cmd("Lspsaga hover_doc")
      end
    end, { desc = "Peek fold or hover" })
  '';
}
