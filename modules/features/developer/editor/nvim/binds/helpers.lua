-- Shared helpers ─────────────────────────────────────────────────────
-- binds.nix concatenates every binds/*.lua after this file, so these
-- locals (map, wk, o) stay in scope for all of them.
local map = vim.keymap.set
local wk = require("which-key")

-- Leader = space  ────────────────────────────────────────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function o(desc)
  return { noremap = true, silent = false, desc = desc }
end
