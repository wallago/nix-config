vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN]  = "󰗖",
      [vim.diagnostic.severity.HINT]  = "󰌶",
      [vim.diagnostic.severity.INFO]  = "󰋽",
    }
  },
  underline = true,
  virtual_text = false,
  update_in_insert = true,
  severity_sort = false,
  float = {
    border = 'rounded',
    source = 'always',
    header = "",
    prefix = "",
  },
})


vim.o.updatetime = 300
vim.opt.signcolumn = "yes"
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})
