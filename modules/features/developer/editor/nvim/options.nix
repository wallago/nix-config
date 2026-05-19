{
  flake.homeModules.nvimOptions = {
    programs.neovim.initLua = ''
      local opt = vim.opt

      -- ── UI ──────────────────────────────────────────────────────────────
      opt.number         = true     -- show absolute number on current line
      opt.relativenumber = true     -- relative numbers on other lines (jumps: 5e, 3i…)
      opt.signcolumn     = "yes"    -- always show the gutter (no text-jump when LSP/marks appear)
      opt.cursorline     = true     -- highlight the current line
      opt.termguicolors  = true     -- 24-bit colors (required by catppuccin etc.)
      opt.showmode       = false    -- lualine already shows it
      opt.laststatus     = 3        -- single global statusline across splits
      opt.scrolloff      = 8        -- keep 8 lines of context above/below cursor
      opt.sidescrolloff  = 8        -- same horizontally
      opt.cmdheight      = 1
      opt.pumheight      = 12       -- max items in completion popup
      opt.winminwidth    = 5

      -- ── Editing ─────────────────────────────────────────────────────────
      opt.expandtab      = true     -- spaces, not tabs
      opt.tabstop        = 2
      opt.shiftwidth     = 2
      opt.softtabstop    = 2
      opt.smartindent    = true
      opt.breakindent    = true     -- wrapped lines keep their indent
      opt.wrap           = false    -- don't wrap by default
      opt.linebreak      = true     -- ...but if you :set wrap, break on words
      opt.undofile       = true     -- persistent undo across restarts
      opt.swapfile       = false    -- the W325 warning you hit — gone
      opt.confirm        = true     -- ask before failing on unsaved changes

      -- ── Search ──────────────────────────────────────────────────────────
      opt.ignorecase     = true
      opt.smartcase      = true     -- case-sensitive if you type a capital
      opt.hlsearch       = true
      opt.incsearch      = true

      -- ── Splits ──────────────────────────────────────────────────────────
      opt.splitright     = true     -- vertical splits open on the right
      opt.splitbelow     = true     -- horizontal splits open below

      -- ── Performance & feel ──────────────────────────────────────────────
      opt.updatetime     = 200      -- faster CursorHold (LSP hover, gitsigns…)
      opt.timeoutlen     = 400      -- mapped-sequence timeout (which-key feels snappier)
      opt.mouse          = "a"
      opt.clipboard      = "unnamedplus" -- share system clipboard

      -- ── Whitespace visibility ───────────────────────────────────────────
      opt.list           = true
      opt.listchars      = { tab = "→ ", trail = "·", nbsp = "␣" }

      -- ── Session (works with persistence.nvim) ───────────────────────────
      opt.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"

      -- ── Folding (modern treesitter folds) ───────────────────────────────
      opt.foldlevel      = 99
      opt.foldlevelstart = 99
      opt.foldenable     = true
    '';
  };
}
