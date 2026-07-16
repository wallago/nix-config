-- Fix unhelpful built-in descriptions in the which-key popup  ────────
wk.add({
  { "gx", desc = "Opens filepath or URI under cursor" },
  { "g;", desc = "Older edit position" },
  { "g,", desc = "Newer edit position" },
})

-- Label the <leader> prefixes as named groups in the popup  ──────────
wk.add({
  { "<leader>z", group = "note" },
  { "<leader>b", group = "buffer" },
  { "<leader>d", group = "dap" },
  { "<leader>f", group = "telescope" },
  { "<leader>m", group = "mark" },
  { "<leader>q", group = "session" },
  { "<leader>t", group = "tab" },
  { "<leader>x", group = "trouble" },
  { "<leader>R", group = "http" },
  { "<leader>n", group = "tips" },
  { "]", group = "next" },
  { "[", group = "prev" },
})

-- Hide from the which-key popup (keys still work, just unlisted)  ────
wk.add({
  { "f", hidden = true },
  { "F", hidden = true },
  { "t", hidden = true },
  { "Y", hidden = true },
  { "&", hidden = true },
  { ";", hidden = true },
  { ",", hidden = true },
  { "gt", hidden = true },
  { "gT", hidden = true },
  { "gO", hidden = true },
  { "g%", hidden = true },
  { "gw", hidden = true, mode = "n" },
  { "g~", hidden = true, mode = "n" },
  { "gc", hidden = true, mode = "n" },
})
