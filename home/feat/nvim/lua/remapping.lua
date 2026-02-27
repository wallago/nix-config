-- https://ncs.dev/
local wk = require("which-key")

vim.keymap.set("i", "<C-/>", function()
  wk.show({ mode = "i" })
end, { desc = "Show insert mode keys" })

vim.keymap.set("n", "<C-/>", function()
  wk.show({ mode = "n" })
end, { desc = "Show normal mode keys" })

-- Missing desc
wk.add({
  -- Nav
  { "g_", desc = "last CHAR of line", mode = "n" },
  { "G", desc = "Last line / {count} go to line", mode = "n" },
  { "<C-d>", desc = "Move half page down", mode = "n" },
  { "<C-u>", desc = "Move half page up", mode = "n" },
  { "<C-f>", desc = "Move page down", mode = "n" },
  { "<C-b>", desc = "Move page up", mode = "n" },
  { "<C-y>", desc = "Scroll up", mode = "n" },
  { "(", desc = "Prev sentence", mode = "n" },
  { ")", desc = "Next sentence", mode = "n" },
  { "{", desc = "Prev paragraph", mode = "n" },
  { "}", desc = "Next paragraph", mode = "n" },

  -- Insert
  { "a", desc = "Append after cursor", mode = "n" },
  { "A", desc = "Append at eol", mode = "n" },
  { "<C-c>", desc = "Exit insert", mode = "i" },
  { "<C-h>", desc = "Delete char before cursor", mode = "i" },
  { "<C-w>", desc = "Delete word before cursor", mode = "i" },
  { "<C-u>", desc = "Delete line before cursor", mode = "i" },
  { "<C-t>", desc = "Indent line", mode = "i" },
  { "<C-d>", desc = "Un-indent line", mode = "i" },
  { "<C-n>", desc = "Auto-complete next match", mode = "i" },
  { "<C-p>", desc = "Auto-complete prev match", mode = "i" },
  { "<C-a>", desc = "Insert prev inserted text", mode = "i" },

  -- Editing
  { "r", desc = "Replace char", mode = "n" },
  { "R", desc = "Replace", mode = "n" },
  { "gJ", desc = "Join line below without space", mode = "n" },
  { "cc", desc = "Change entire line", mode = "n" },
  { "C", desc = "Change to eol", mode = "n" },
  { "s", desc = "Delete char + Insert", mode = "n" },
  { "S", desc = "Delete line + Insert", mode = "n" },
  { "x", desc = "Delete char under cursor", mode = "n" },
  { "X", desc = "Delete char before cursor", mode = "n" },
  { "dd", desc = "Delete line", mode = "n" },
  { "D", desc = "Delete to eol", mode = "n" },
  { "u", desc = "Undo", mode = "n" },
  { "U", desc = "Undo all changes on line", mode = "n" },
  { "<C-r>", desc = "Redo", mode = "n" },
  { ".", desc = "Repeat last command", mode = "n" },
  { ">>", desc = "Indent line", mode = "n" },
  { "<<", desc = "Un-indent line", mode = "n" },
  { "==", desc = "Auto indent line", mode = "n" },
  { "gg=G", desc = "Auto indent file", mode = "n" },

  -- Visual
  { "<C-v>", desc = "Visual block", mode = "n" },

  { "q", desc = "Stop recording macro", mode = "n" }
})

-- Displaced keys

-- h key
vim.keymap.set({ "n", "x" }, "n", "h", { noremap = true, desc = "Left" })
vim.keymap.set({ "n", "x" }, "h", "<Nop>", { noremap = true })
wk.add({ "h", hidden = true, mode = "n" })
vim.keymap.set({ "n" }, "N", "H", { noremap = true, desc = "Top line of window" })
vim.keymap.set({ "n" }, "H", "<Nop>", { noremap = true })
wk.add({ "H", hidden = true, mode = "n" })

-- o key
vim.keymap.set({ "n" }, "j", "o", { noremap = true, desc = "Open new line below" })
vim.keymap.set({ "n" }, "o", "<Nop>", { noremap = true })
wk.add({ "o", hidden = true, mode = "n" })
vim.keymap.set({ "n" }, "J", "O", { noremap = true, desc = "Join line below to current" })
vim.keymap.set({ "n" }, "O", "<Nop>", { noremap = true })
wk.add({ "O", hidden = true, mode = "n" })

-- j key
vim.keymap.set({ "n" }, "<leader>J", "J", { noremap = true, desc = "Open new line above" })
vim.keymap.set({ "n", "x" }, "e", "j", { noremap = true, desc = "Down / {count} lines down" })
vim.keymap.set({ "n", "x" }, "j", "<Nop>", { noremap = true })
wk.add({ "j", hidden = true, mode = "n" })

-- k key
vim.keymap.set({ "n", "x" }, "i", "k", { noremap = true, desc = "Up / {count} lines up" })
vim.keymap.set({ "n", "x" }, "k", "<Nop>", { noremap = true })
wk.add({ "k", hidden = true, mode = "n" })

-- l key
vim.keymap.set({ "n", "x" }, "o", "l", { noremap = true, desc = "Right" })
vim.keymap.set({ "n", "x" }, "l", "<Nop>", { noremap = true })
wk.add({ "l", hidden = true, mode = "n" })
vim.keymap.set({ "n" }, "O", "L", { noremap = true, desc = "Bottom line of window" })
vim.keymap.set({ "n" }, "L", "<Nop>", { noremap = true })
wk.add({ "L", hidden = true, mode = "n" })

-- e key
vim.keymap.set({ "n" }, "k", "e", { noremap = true, desc = "Next end of word" })
vim.keymap.set({ "n" }, "e", "<Nop>", { noremap = true })
wk.add({ "e", hidden = true, mode = "n" })
vim.keymap.set({ "n" }, "K", "E", { noremap = true, desc = "Next end of WORD" })
vim.keymap.set({ "n" }, "E", "<Nop>", { noremap = true })
wk.add({ "E", hidden = true, mode = "n" })

-- i key
vim.keymap.set({ "n" }, "l", "i", { noremap = true, desc = "Insert before cursor" })
vim.keymap.set({ "n" }, "i", "<Nop>", { noremap = true })
wk.add({ "i", hidden = true, mode = "n" })
vim.keymap.set({ "n" }, "L", "I", { noremap = true, desc = "Insert at beginning of line" })
vim.keymap.set({ "n" }, "I", "<Nop>", { noremap = true })
wk.add({ "I", hidden = true, mode = "n" })
vim.keymap.set({ "n" }, "^K", "^E", { noremap = true, desc = "Scroll down" })
vim.keymap.set({ "n" }, "^E", "<Nop>", { noremap = true })
wk.add({ "^E", hidden = true, mode = "n" })

-- n key

-- o key

-- local modes = { "n", "x" }

-- -- NEIO navigation (home row)
-- vim.keymap.set(modes, "n", "h", { noremap = true, desc = "Left" })
-- vim.keymap.set(modes, "e", "j", { noremap = true, desc = "Down" })
-- vim.keymap.set(modes, "i", "k", { noremap = true, desc = "Up" })
-- vim.keymap.set(modes, "o", "l", { noremap = true, desc = "Right" })

-- -- Displaced keys
-- vim.keymap.set(modes, "h", "e", { noremap = true, desc = "Next end of word" })
-- vim.keymap.set(modes, "H", "E", { noremap = true, desc = "Next end of WORD" })
-- vim.keymap.set("n", "Y", "y$", { noremap = true, desc = "Yank to end of line" })
-- vim.keymap.set("n", "j", "u", { noremap = true, desc = "Undo" })
-- vim.keymap.set("n", "J", "<C-r>", { noremap = true, desc = "Redo" })
-- vim.keymap.set("n", "<leader>j", "J", { noremap = true, desc = "Join lines" })

-- -- Insert/open only in normal mode
-- vim.keymap.set("n", "u", "i", { noremap = true, desc = "Insert" })
-- vim.keymap.set(, "U", "I", { noremap = true, desc = "Insert line start" })
-- vim.keymap.set("n", "l", "o", { noremap = true, desc = "Open line below" })
-- vim.keymap.set("n", "L", "O", { noremap = true, desc = "Open line above" })

-- -- Window navigation
-- vim.keymap.set("n", "<C-w>n", "<C-w>h", { noremap = true, desc = "Go to letf win" })
-- vim.keymap.set("n", "<C-w>e", "<C-w>j", { noremap = true, desc = "Go to down win" })
-- vim.keymap.set("n", "<C-w>i", "<C-w>k", { noremap = true, desc = "Go to top win" })
-- vim.keymap.set("n", "<C-w>o", "<C-w>l", { noremap = true, desc = "Go to right win" })

-- -- Window moves
-- vim.keymap.set("n", "<C-w>N", "<C-w>H", { noremap = true, desc = "Move win to far left" })
-- vim.keymap.set("n", "<C-w>E", "<C-w>J", { noremap = true, desc = "Move win to far down" })
-- vim.keymap.set("n", "<C-w>I", "<C-w>K", { noremap = true, desc = "Move win to far up" })
-- vim.keymap.set("n", "<C-w>O", "<C-w>L", { noremap = true, desc = "Move win to far right" })

-- -- Clear unused keys
-- vim.keymap.set(modes, "N", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "E", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "Y", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-x>", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-l>", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-p>", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-w>h", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-w>j", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-w>k", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-w>l", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-w>H", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-w>J", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-w>K", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-w>L", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "<C-w><C-d>", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "gO", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "g~", "<Nop>", { noremap = true })
-- vim.keymap.set(modes, "gcu", "<Nop>", { remap = true })

-- vim.keymap.set('n', '<C-p>', '<C-f>', { noremap = true, desc = "Page down" })
-- vim.keymap.set('n', '<C-f>', '<C-u>', { noremap = true, desc = "Half page up" })
-- vim.keymap.set('n', '<C-u>', '<C-e>', { noremap = true, desc = "Scroll up" })

-- local wk = require("which-key")
-- wk.add({
--   { "E", hidden = true },
--   { "N", hidden = true },
--   { "Y", hidden = true },
--   { "<Plug>", hidden = true },
--   { "<C-E>", hidden = true },
--   { "<C-P>", hidden = true },
--   { "<C-w>h", hidden = true },
--   { "<C-w>j", hidden = true },
--   { "<C-w>k", hidden = true },
--   { "<C-w>l", hidden = true },
--   { "<C-w>H", hidden = true },
--   { "<C-w>J", hidden = true },
--   { "<C-w>K", hidden = true },
--   { "<C-w>L", hidden = true },
--   { "<C-w><C-D>", hidden = true },
--   { "gO", hidden = true },
--   { "g~", hidden = true },
--   { "gcu", hidden = true },
--   { "gcc", hidden = true },
--   { "<C-Y>", desc = "Scroll up" },
--   { "<C-U>", desc = "Scroll down" },
--   { "<C-B>", desc = "Page up" },
--   { "<C-P>", desc = "Page down" },
--   { "<C-F>", desc = "Half Page up" },
--   { "<C-D>", desc = "Half Page down" },
--   { "<C-L>", desc = "Redraw screen" },
--   { "<C-A>", desc = "Increase Number" },
--   { "<C-X>", desc = "Decrease Number" },
-- })
