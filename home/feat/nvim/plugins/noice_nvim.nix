{ pkgs, c }: {
  plugins = with pkgs.vimPlugins; [ noice-nvim ];
  config = ''
    vim.api.nvim_set_hl(0, "NoiceCursor",                   { link = "TermCursor" })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder",       { fg = "${c.primary}", bg = "${c.surface}" })
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon",              { link = "NoiceCmdlinePopupBorder" })
    vim.api.nvim_set_hl(0, "NoiceConfirmBorder",            { link = "NoiceCmdlinePopupBorder" })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { fg = "${c.yellow}", bg = "${c.surface}" })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { link = "NoiceCmdlinePopupBorderSearch" })

    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true, 
      },
    })
  '';
}
