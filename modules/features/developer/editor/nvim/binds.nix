{
  flake.homeModules.nvimBinds = {
    programs.neovim.initLua = ''
      local map = vim.keymap.set

      -- Leader = space  ────────────────────────────────────────────────────
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      local opts = { noremap = true, silent = false }
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

      -- Visual-line aware variants (so e/i don't skip wrapped lines)  ──────
      map("n", "e", "gj", o("↓ down (visual line)"))
      map("n", "i", "gk", o("↑ up (visual line)"))
      map("v", "e", "gj", o("↓ down (visual line)"))
      map("v", "i", "gk", o("↑ up (visual line)"))

      -- Window navigation: <C-w> + n/e/i/o  ────────────────────────────────
      map("n", "<C-w>n", "<C-w>h", opts)
      map("n", "<C-w>e", "<C-w>j", opts)
      map("n", "<C-w>i", "<C-w>k", opts)
      map("n", "<C-w>o", "<C-w>l", opts)
    '';
  };
}
