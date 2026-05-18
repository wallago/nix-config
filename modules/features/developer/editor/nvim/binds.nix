{
  flake.homeModules.nvimBinds = {
    programs.neovim.initLua = ''
      local map = vim.keymap.set

      -- Leader = space  ────────────────────────────────────────────────────
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      local opts = { noremap = true, silent = false }
      -- Movement: NEIO replaces HJKL  ──────────────────────────────────────
      for _, mode in ipairs({ "n", "v", "x", "o" }) do
        map(mode, "n", "h", opts)
        map(mode, "e", "j", opts)
        map(mode, "i", "k", opts)
        map(mode, "o", "l", opts)

        -- screen-edge moves
        map(mode, "N", "H", opts)
        map(mode, "E", "L", opts)
        map(mode, "I", "K", opts)
        -- "O" doesn't have a useful uppercase target on the right side,
        -- leave it free or bind something custom.
      end

      -- Re-home the displaced commands  ────────────────────────────────────
      map({ "n", "v" }, "h", "n", opts)
      map({ "n", "v" }, "H", "N", opts)
      map("n", "k", "e", opts)
      map("n", "K", "E", opts)
      map("n", "l", "i", opts)
      map("n", "L", "I", opts)
      map("n", "j", "o", opts)
      map("n", "J", "O", opts)

      -- Visual-line aware variants (so e/i don't skip wrapped lines)  ──────
      map("n", "e", "gj", opts)
      map("n", "i", "gk", opts)
      map("v", "e", "gj", opts)
      map("v", "i", "gk", opts)

      -- Window navigation: <C-w> + n/e/i/o  ────────────────────────────────
      map("n", "<C-w>n", "<C-w>h", opts)
      map("n", "<C-w>e", "<C-w>j", opts)
      map("n", "<C-w>i", "<C-w>k", opts)
      map("n", "<C-w>o", "<C-w>l", opts)
    '';
  };
}
