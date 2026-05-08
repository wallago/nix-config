{
  flake.homeModules.nvimBinds = {
    programs.neovim.extraConfig = ''
      local map = vim.keymap.set
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
    '';
  };
}
