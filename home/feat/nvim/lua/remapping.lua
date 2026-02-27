local modes = { "n", "x", "o" }

-- NEIO navigation (home row)
vim.keymap.set(modes, "n", "h", { noremap = true, desc = "Left" })
vim.keymap.set(modes, "e", "j", { noremap = true, desc = "Down" })
vim.keymap.set(modes, "i", "k", { noremap = true, desc = "Up" })
vim.keymap.set(modes, "o", "l", { noremap = true, desc = "Right" })

-- Displaced keys
vim.keymap.set(modes, "h", "e", { noremap = true, desc = "Next end of word" })
vim.keymap.set(modes, "H", "E", { noremap = true, desc = "Next end of WORD" })
vim.keymap.set(modes, "u", "i", { noremap = true, desc = "Insert" })
vim.keymap.set(modes, "U", "I", { noremap = true, desc = "Insert line start" })
vim.keymap.set(modes, "l", "o", { noremap = true, desc = "Open line below" })
vim.keymap.set(modes, "L", "O", { noremap = true, desc = "Open line above" })
vim.keymap.set("n", "Y", "y$", { noremap = true, desc = "Yank to end of line" })
vim.keymap.set("n", "j", "u", { noremap = true, desc = "Undo" })
vim.keymap.set("n", "J", "<C-r>", { noremap = true, desc = "Redo" })
vim.keymap.set("n", "<leader>j", "J", { noremap = true, desc = "Join lines" })

-- Visual mode: don't clobber native i/o for text objects
-- "inner" and "a" text objects still work since we only remap in operator modes
-- but be aware: `diw` becomes `duw` (delete inner word) with this setup

-- Window navigation
vim.keymap.set("n", "<C-w>n", "<C-w>h", { noremap = true, desc = "Go to letf win" })
vim.keymap.set("n", "<C-w>e", "<C-w>j", { noremap = true, desc = "Go to down win" })
vim.keymap.set("n", "<C-w>i", "<C-w>k", { noremap = true, desc = "Go to top win" })
vim.keymap.set("n", "<C-w>o", "<C-w>l", { noremap = true, desc = "Go to right win" })

-- Window moves
vim.keymap.set("n", "<C-w>N", "<C-w>H", { noremap = true, desc = "Move win to far left" })
vim.keymap.set("n", "<C-w>E", "<C-w>J", { noremap = true, desc = "Move win to far down" })
vim.keymap.set("n", "<C-w>I", "<C-w>K", { noremap = true, desc = "Move win to far up" })
vim.keymap.set("n", "<C-w>O", "<C-w>L", { noremap = true, desc = "Move win to far right" })

-- Ctrl navigation (scrolling / window switching)
-- vim.keymap.set(modes, "<C-n>", "<C-h>", { noremap = true })
-- vim.keymap.set(modes, "<C-e>", "<C-j>", { noremap = true })
-- vim.keymap.set(modes, "<C-i>", "<C-k>", { noremap = true })
-- vim.keymap.set(modes, "<C-o>", "<C-l>", { noremap = true })

-- Clear unused keys
vim.keymap.set(modes, "N", "<Nop>", { noremap = true })
vim.keymap.set(modes, "E", "<Nop>", { noremap = true })
vim.keymap.set(modes, "Y", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-x>", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-l>", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-p>", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-w>h", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-w>j", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-w>k", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-w>l", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-w>H", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-w>J", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-w>K", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-w>L", "<Nop>", { noremap = true })
vim.keymap.set(modes, "<C-w><C-d>", "<Nop>", { noremap = true })
vim.keymap.set(modes, "gO", "<Nop>", { noremap = true })
vim.keymap.set(modes, "g~", "<Nop>", { noremap = true })
vim.keymap.set(modes, "gcu", "<Nop>", { remap = true })

vim.keymap.set('n', '<C-p>', '<C-f>', { noremap = true, desc = "Page down" })
vim.keymap.set('n', '<C-f>', '<C-u>', { noremap = true, desc = "Half page up" })
vim.keymap.set('n', '<C-u>', '<C-e>', { noremap = true, desc = "Scroll up" })
local wk = require("which-key")

wk.add({
  umekksnzsldulbfzzeugbgpzfbi

  { "E", hidden = true },
  { "N", hidden = true },
  { "Y", hidden = true },
  { "<Plug>", hidden = true },
  { "<C-E>", hidden = true },
  { "<C-P>", hidden = true },
  { "<C-w>h", hidden = true },
  { "<C-w>j", hidden = true },
  { "<C-w>k", hidden = true },
  { "<C-w>l", hidden = true },
  { "<C-w>H", hidden = true },
  { "<C-w>J", hidden = true },
  { "<C-w>K", hidden = true },
  { "<C-w>L", hidden = true },
  { "<C-w><C-D>", hidden = true },
  { "gO", hidden = true },
  { "g~", hidden = true },
  { "gcu", hidden = true },
  { "gcc", hidden = true },
  { "<C-Y>", desc = "Scroll up" },
  { "<C-U>", desc = "Scroll down" },
  { "<C-B>", desc = "Page up" },
  { "<C-P>", desc = "Page down" },
  { "<C-F>", desc = "Half Page up" },
  { "<C-D>", desc = "Half Page down" },
  { "<C-L>", desc = "Redraw screen" },
  { "<C-A>", desc = "Increase Number" },
  { "<C-X>", desc = "Decrease Number" },
})
