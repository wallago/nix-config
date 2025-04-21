{ config, pkgs, ... }:
let
  inherit (config) colorscheme;
  hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors);

  rawPluginModules = [
    ./plugins/nvim_treesitter.nix
    ./plugins/nvim_lspconfig.nix
    ./plugins/nvim_cmp.nix
    ./plugins/telescope_nvim.nix
    ./plugins/neogit.nix
    ./plugins/which_key_nvim.nix
  ];

  pluginModules = map (file: import file { inherit pkgs; }) rawPluginModules;

  getOrDefault = name: default: module:
    if builtins.hasAttr name module then module.${name} else default;

  allPlugins = builtins.concatLists (map (m: m.plugins) pluginModules);
  allDeps =
    builtins.concatLists (map (m: getOrDefault "deps" [ ] m) pluginModules);
  allConfig = builtins.concatStringsSep "\n"
    (map (m: getOrDefault "config" "" m) pluginModules);
in {
  home.sessionVariables = {
    EDITOR = "nvim";
    COLORTERM = "truecolor";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = allPlugins ++ (with pkgs.vimPlugins; [
      lazy-nvim
      gitsigns-nvim
      nvim-web-devicons
      vim-commentary
    ]);

    extraLuaConfig = ''
      -- General Settings
      vim.opt.number = true
      vim.opt.expandtab = true
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.smartindent = true
      -- Visual Settings
      vim.opt.termguicolors = true
      vim.opt.cursorline = true
      vim.opt.cursorlineopt = "number"
      -- Performance & UI Tweaks
      vim.opt.signcolumn = "yes"
      vim.opt.foldmethod = "indent"
      vim.opt.foldlevel = 99
      vim.opt.mouse = "a"
      -- Search & Navigation
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.incsearch = true
      vim.opt.hlsearch = true
      -- Clipboard & Yank Settings
      vim.opt.clipboard = "unnamedplus"
      vim.opt.history = 1000
      -- Undo & Backup
      vim.opt.undofile = true
      vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
      vim.opt.backup = false
      vim.opt.writebackup = false
      -- Spelling & Auto-Completion
      vim.opt.spell = false
      vim.opt.completeopt = { "menu", "menuone", "noselect" }
      -- Miscellaneous
      -- vim.opt.showmode = false
      -- vim.opt.wrap = false
      ${allConfig}
    '';
  };

  home.packages = allDeps;
}

#   withNodeJs = true;
#   withRuby = true;
#   withPython3 = true;
#   extraConfig = ''
#     ${builtins.readFile ./config.vim}
#   '';
#   plugins = with pkgs.vimPlugins; [
#     toggleterm-nvim # -------> floating terminal
#     nvim-notify # -----------> notify
#     vim-dadbod-ui # ---------> navigation database gui
#     oil-nvim # --------------> file explorer that lets you edit your filesystem like a normal Neovim buffer.
#     plenary-nvim # ----------> All the lua functions I don't want to write twice.
#     openscad-nvim # --------->
#     coc-nvim # --------------> conquer of completion nvim
#     coc-lua # ---------------> conquer of completion lua
#     coc-rust-analyzer # -----> conquer of completion rust analyzer
#     coc-tailwindcss # -------> conquer of completion of tailwindcss
#     coc-fzf # ---------------> conquer of completion for fzf
#     vim-nix # ---------------> writing Nix expressions
#     conform-nvim # ----------> formating code
#     markdown-nvim # ---------> beautify markdown
#     markdown-preview-nvim # -> preview markdown file
#     rest-nvim # -------------> asynchronous Neovim HTTP client
#     rustaceanvim # ----------> Supercharge your Rust experience
#     actions-preview-nvim # --> Better actions preview
#     inc-rename-nvim # -------> LSP renaming with immediate visual feedback
#     vim-flog # --------------> git graph
#     fugitive # --------------> git commands
#     lazygit-nvim # ----------> git interface
#     bufferline-nvim # -------> tabs behavior
#     nvim-colorizer-lua # ----> show color by code
#     nvim-tree-lua # ---------> file explorer
#     nvim-web-devicons # -----> provide Nerd Font icons
#   ];
# };
#
# home.packages = with pkgs; [
#   luajit # ----------------> Just-In-Time compiler for Lua programming language
#   stylua # ----------------> Opinionated Lua code formatter
#   nixfmt-rfc-style # ------> Formatter for Nix code following RFC style
#   prettierd # -------------> Prettier daemon for faster formatting
#   isort # -----------------> Python utility to sort imports alphabetically
#   black # -----------------> The uncompromising Python code formatter
#   grc # -------------------> Generic text colouriser
# ];
#
# home.sessionVariables = {
#   EDITOR = "nvim";
# };
# }

