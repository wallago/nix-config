# 🏠 Home Configuration

- `home.sessionVariables`
  - `EDITOR = "nvim"`\
    ▶️ sets Neovim as the default text editor
  - `COLORTERM = "truecolor"`\
    ▶️ enables 24-bit color support in terminal UIs

# 📝 Neovim Configuration

- `programs.neovim`
  - `enable = true`\
    ▶️ enables Neovim via Home Manager
  - `viAlias = true`, `vimAlias = true`, `vimdiffAlias = true`\
    ▶️ makes Neovim accessible via `vi`, `vim`, or `vimdiff` commands
  - `plugins`\
    ▶️ all plugins describes bellow
  - `extraLuaConfig = '''...'''`\
    ▶️ embeds Lua config with:

# 📦 System packages

- `environment.systemPackdages`
  - `pkgs.vimPlugins.markdown-preview-nvim`\
    ▶️ live Markdown preview in the browser
  - `pkgs.vimPlugins.vim-commentary`\
    ▶️ quick commenting/uncommenting with `gc` keybinding
  - `pkgs.vimPlugins.actions-preview-nvim`\
    ▶️ shows code actions in a preview window
  - `pkgs.vimPlugins.conform-nvim`\
    ▶️ plugin for code formatting using external tools
  - `pkgs.nodePackages.prettier`\
    ▶️ code formatter for JavaScript, TypeScript, JSON, etc.
  - `pkgs.vimPlugins.gitsigns-nvim`\
    ▶️ Git integration showing changes in the sign column
  - `pkgs.vimPlugins.inc-rename-nvim`\
    ▶️ inline rename LSP plugin for Neovim
  - `pkgs.vimPlugins.lualine-nvim`\
    ▶️ fast and customizable statusline plugin
  - `pkgs.vimPlugins.neogit`\
    ▶️ Magit-style Git interface inside Neovim
  - `pkgs.vimPlugins.noice-nvim`\
    ▶️ modern UI for Neovim messages and LSP progress
  - `pkgs.vimPlugins.nvim-cmp`\
    ▶️ completion engine for Neovim
  - `pkgs.vimPlugins.cmp-nvim-lsp`\
    ▶️ LSP source for `nvim-cmp`
  - `pkgs.vimPlugins.cmp-buffer`\
    ▶️ buffer source for `nvim-cmp`
  - `pkgs.vimPlugins.cmp-path`\
    ▶️ path source for `nvim-cmp`
  - `pkgs.vimPlugins.cmp-cmdline`\
    ▶️ command-line source for `nvim-cmp`
  - `pkgs.vimPlugins.cmp-nvim-lsp-signature-help`\
    ▶️ signature help source for `nvim-cmp`
  - `pkgs.vimPlugins.cmp-nvim-lua`\
    ▶️ Neovim Lua API completion source
  - `pkgs.vimPlugins.nvim-colorizer-lua`\
    ▶️ displays color codes with real colors in the buffer
  - `pkgs.vimPlugins.nvim-lspconfig`\
    ▶️ easy LSP configuration for Neovim
  - `pkgs.nixd`\
    ▶️ LSP server for Nix
  - `pkgs.nixfmt-classic`\
    ▶️ formatter for Nix expressions
  - `pkgs.vimPlugins.nvim-notify`\
    ▶️ fancy notification UI for Neovim
  - `pkgs.vimPlugins.nvim-treesitter`\
    ▶️ syntax highlighting and parsing using Tree-sitter
  - `pkgs.vimPlugins.nvim-treesitter-parsers.XXX`\
    ▶️ Tree-sitter parsers for specific languages (e.g., `lua`, `nix`, `rust`)
  - `pkgs.gcc`\
    ▶️ GNU Compiler Collection
  - `pkgs.nodejs`\
    ▶️ JavaScript runtime
  - `pkgs.tree-sitter`\
    ▶️ CLI for Tree-sitter grammar generation and testing
  - `pkgs.grc`\
    ▶️ colorizes command-line output (e.g., `ping`, `netstat`)
  - `pkgs.vimPlugins.nvim-web-devicons`\
    ▶️ file icons for plugins like Telescope or NERDTree
  - `pkgs.vimPlugins.oil-nvim`\
    ▶️ modern file explorer inside Neovim
  - `pkgs.vimPlugins.mini-icons`\
    ▶️ lightweight icon set for Neovim UI
  - `pkgs.vimPlugins.rustaceanvim`\
    ▶️ full Rust support including LSP and tools integration
  - `pkgs.rust-bin.nightly.latest.complete`\
    ▶️ rust toolchains
  - `pkgs.vimPlugins.smear-cursor-nvim`\
    ▶️ adds a smear trail animation to the cursor
  - `pkgs.vimPlugins.telescope-nvim`\
    ▶️ fuzzy finder UI for files, symbols, and more
  - `pkgs.vimPlugins.trouble-nvim`\
    ▶️ diagnostic list UI for LSP, quickfix, etc.
  - `pkgs.vimPlugins.which-key-nvim`\
    ▶️ displays available keybindings in a popup
