# > Neovim configuration

### 🔹 Variables / Functions

+ `hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors)`\
▶️ generates a unique hash from the current `colorscheme.colors` to uniquely identify the theme

---

+ `home.sessionVariables`\
▶️ defines editor-related environment variables
    + `EDITOR = "nvim"`\
    ▶️ sets Neovim as the default editor
    + `COLORTERM = "truecolor"`\
    ▶️ forces terminal to use full 24-bit color
+ `programs.neovim`
    + `enable = true`\
    ▶️ enables Neovim through Home Manager
    + `viAlias = true`\
    ▶️ symlink `vi` to `nvim` binary
    + `vimAlias = true`\
    ▶️ symlink `vim` to `nvim` binary
    + `vimdiffAlias = true`\
    ▶️ alias `vimdiff` to `nvim -d`
    + `plugins`
        + `nvim-treesitter`\
        ▶️ better syntax highlighting, code parsing, and structural analysis
        + `nvim-lspconfig`\
        ▶️ common configurations for built-in LSP support
        + `telescope-nvim`\
        ▶️ fuzzy finder and picker UI for files, buffers, LSP, and more
        + `lazy-nvim`\
        ▶️ modern plugin manager
        + `nvim-cmp`\
        ▶️ completion engine
            + `cmp-nvim-lsp`\
            ▶️ LSP source for `nvim-cmp`
            + `cmp-nvim-buffer`\
            ▶️ buffer word source for autocompletion
            + `cmp-nvim-path`\
            ▶️ filesystem path completion source
            + `cmp-nvim-cmdline`\
            ▶️ command line `:` and search mode `/`, `?`
        + `luasnip`\
        ▶️ snippet engine
        + `gitsigns-nvim`\
        ▶️ Git diff signs in the sign column (added, changed, removed)
        + `nvim-web-devicons`\
        ▶️ file icons 
        + `which-key-nvim`\
        ▶️ displays available keybindings in a popup
        + `neogit`\
        ▶️ Git interface manager
        + `vim-commentary`\
        ▶️ comment stuff help

 
