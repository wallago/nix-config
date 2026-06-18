{
  flake.homeModules.nvimBinds = {
    programs.neovim.initLua = ''
      local map = vim.keymap.set
      local wk = require("which-key")

      -- Leader = space  ────────────────────────────────────────────────────
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      local function o(desc) 
        return { noremap = true, silent = false, desc = desc } 
      end

      -- Movement: NEIO replaces HJKL  ──────────────────────────────────────
      for _, mode in ipairs({ "n", "v", "x", "o" }) do
        map(mode, "n", "h", o("← left"))
        map(mode, "e", "j", o("↓ down"))
        map(mode, "i", "k", o("↑ up"))
        map(mode, "o", "l", o("→ right"))

        map(mode, "I", "H", o("Top of screen"))
        map(mode, "E", "L", o("Bottom of screen"))
        map(mode, "T", "K", o("Look up keyword"))
      end

      -- Re-home the displaced commands  ────────────────────────────────────
      map({ "n", "v" }, "h", "n", o("Next search"))
      map({ "n", "v" }, "H", "N", o("Prev search"))
      map("n", "k", "e", o("End of word"))
      map("n", "K", "E", o("End of WORD"))
      map("n", "l", "i", o("Insert"))
      map("n", "L", "I", o("Insert at line start"))
      map("n", "j", "o", o("Open line below"))
      map("n", "J", "O", o("Open line above"))
      map("n", "gk", "ge", o("Prev end of word"))

      -- Visual-line aware variants (so e/i don't skip wrapped lines)  ──────
      map("n", "e", "gj", o("↓ down (visual line)"))
      map("n", "i", "gk", o("↑ up (visual line)"))
      map("v", "e", "gj", o("↓ down (visual line)"))
      map("v", "i", "gk", o("↑ up (visual line)"))

      -- Window navigation: <C-w> + n/e/i/o  ────────────────────────────────
      map("n", "<C-w>n", "<C-w>h", o("← left"))
      map("n", "<C-w>e", "<C-w>j", o("↓ bottom"))
      map("n", "<C-w>i", "<C-w>k", o("↑ top"))
      map("n", "<C-w>o", "<C-w>l", o("→ right"))

      -- Tab ────────────────────────────────────────────────────────────────
      map("n", "<leader>tn", "<CMD>tabnew<CR>",   o("Tab: new"))
      map("n", "<leader>tc", "<CMD>tabclose<CR>", o("Tab: close"))
      map("n", "<leader>to", "<CMD>tabonly<CR>",  o("Tab: close others"))
      map("n", "<leader>tf", "<CMD>tabmove +1<CR>", o("Tab: move forward"))
      map("n", "<leader>tb", "<CMD>tabmove -1<CR>",  o("Tab: close backward"))
      -- map("n", "<TAB>", "gt", o("Tab: next"))
      -- map("n", "<S-TAB>", "gT", o("Tab: prev"))

      -- Buffer ───────────────────────────────────────────────────────────────
      map("n", "<C-q>", "<CMD>q<CR>",   o("Quit"))
      map("n", "<C-x>", "<CMD>x<CR>",   o("Quit & Save"))
      map("n", "<C-o>", "<CMD>qall<CR>",   o("Quit all"))
      map("n", "<C-s>", "<CMD>w<CR>",   o("Save"))

      -- Wrong Desc ─────────────────────────────────────────────────────────
      wk.add({
        { "gx", desc = "Opens filepath or URI under cursor" },
        { "g;", desc = "Older edit position" },
        { "g,", desc = "Newer edit position" },
      })

      -- Unbind ─────────────────────────────────────────────────────────────
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
    '';
  };
}
