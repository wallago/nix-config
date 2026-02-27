{ pkgs, keymap }:
let
  nav = keymap.nav;
in
{
  plugins = with pkgs.vimPlugins; [ which-key-nvim ];
  config = ''
    -- Set leader key
    vim.g.mapleader = " "

    vim.api.nvim_set_hl(0, "WhichKeyIcon", { underline = false })

    local wk = require("which-key")
    wk.setup({
      preset = "modern",
      icons = {
        mappings = true,
        rules = {},
      },
      win = {
        border = "rounded",
        title = true,
        title_pos = "center",
        padding = { 1, 2 },
      },
      layout = {
        spacing = 3,
      },
      sort = { "local", "order", "group", "alphanum", "mod", "lower" },
    })
    wk.add({
      { "f", "<cmd>WhichKey<cr>", desc = "Cheatsheet", icon = "󰌌" },
    })
  '';
}
