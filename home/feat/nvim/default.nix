{ config, pkgs, ... }:
let
  inherit (config) colorscheme;
  hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors);
  c = colorscheme.colors;

  rawPluginModules = [
    ./plugins/actions_preview_nvim.nix
    ./plugins/conform_nvim.nix
    ./plugins/gitsigns_nvim.nix
    ./plugins/inc_rename_nvim.nix
    ./plugins/neogit.nix
    ./plugins/nvim_cmp.nix
    ./plugins/nvim_colorizer_lua.nix
    ./plugins/nvim_lspconfig.nix
    ./plugins/nvim_treesitter.nix
    ./plugins/nvim_web_devicons.nix
    ./plugins/oil_nvim.nix
    ./plugins/rustaceanvim.nix
    ./plugins/smear_cursor_nvim.nix
    ./plugins/telescope_nvim.nix
    ./plugins/trouble_nvim.nix
    ./plugins/which_key_nvim.nix
    ./plugins/mermaid_nvim.nix
    ./plugins/hunk_nvim.nix
    ./plugins/neoscroll_nvim.nix
    ./plugins/lspsaga-nvim.nix
    ./plugins/rest-nvim.nix
    ./plugins/nvim_autopairs.nix
    ./plugins/indent_blankline_nvim.nix
    ./plugins/bufferline_nvim.nix
  ];

  rawPluginColorModules = [
    ./plugins/lualine_nvim.nix
    ./plugins/noice_nvim.nix
    ./plugins/nvim_notify.nix
  ];

  pluginModules = (map (file: import file { inherit pkgs; }) rawPluginModules)
    ++ map (file: import file { inherit pkgs c; }) rawPluginColorModules;

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
      # stand alone
      markdown-preview-nvim
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

      -- Performance improvements
      vim.opt.ttyfast = true
      vim.opt.updatetime = 250
      vim.opt.timeoutlen = 300

      -- Better split behavior
      vim.opt.splitright = true
      vim.opt.splitbelow = true

      -- Show whitespace characters
      vim.opt.list = true
      vim.opt.listchars = {
        tab = '→ ',
        trail = '·',
        extends = '»',
        precedes = '«',
        nbsp = '␣'
      }

      -- Spelling & Auto-Completion
      vim.opt.spell = false
      vim.opt.completeopt = { 
        "menu", -- use a popup menu to show the possible completions 
        "menuone", -- use the popup menu also when there is only one match
        "noselect", -- except that no menu item is pre-selected
        "noinsert", -- do not insert any text for a match until the user selects a match from the menu
      }

      -- Diagnostic 
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN]  = "󰗖",
            [vim.diagnostic.severity.HINT]  = "󰌶",
            [vim.diagnostic.severity.INFO]  = "󰋽",
          }
        },
        underline = true,
        virtual_text = false,
        update_in_insert = true,
        severity_sort = false,
        float = {
          border = 'rounded',
          source = 'always',
          header = "",
          prefix = "",
        },
      })


      vim.o.updatetime = 300
      vim.opt.signcolumn = "yes"
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, { focusable = false })
        end,
      })

      -- Theme
      vim.cmd("highlight clear")
      vim.o.background = "dark"
      vim.g.colors_name = "${hash}"
      vim.api.nvim_set_hl(0, "Normal",       { fg = "${c.on_surface}", bg = "${c.surface}" })
      vim.api.nvim_set_hl(0, "Identifier",   { fg = "${c.red}" })
      vim.api.nvim_set_hl(0, "Visual",       { bg = "${c.surface_container_high}" })
      vim.api.nvim_set_hl(0, "LineNr",       { fg = "${c.surface_variant}" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "${c.yellow}", bold = true })
      vim.api.nvim_set_hl(0, "NormalFloat",  { bg = "${c.surface}", fg = "${c.on_surface}" })
      vim.api.nvim_set_hl(0, "FloatBorder",  { bg = "${c.surface}", fg = "${c.primary}" })
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "${c.primary}" })
      vim.api.nvim_set_hl(0, "Constant",     { fg = "${c.cyan}" })
      vim.api.nvim_set_hl(0, "Function",     { fg = "${c.blue}" })
      vim.api.nvim_set_hl(0, "Type",         { fg = "${c.yellow}" })
      vim.api.nvim_set_hl(0, "Statement",    { fg = "${c.magenta}" })
      vim.api.nvim_set_hl(0, "String",       { fg = "${c.green}" })
      vim.api.nvim_set_hl(0, "Comment",      { fg = "${c.surface_variant}", italic = true })
      vim.api.nvim_set_hl(0, "WinBar", { fg = "${c.on_surface}", bg = "${c.surface}" })
      vim.api.nvim_set_hl(0, "DiagnosticError",   { fg = "${c.red}" })
      vim.api.nvim_set_hl(0, "DiagnosticWarn",    { fg = "${c.yellow}" })
      vim.api.nvim_set_hl(0, "DiagnosticInfo",    { fg = "${c.green}" })
      vim.api.nvim_set_hl(0, "DiagnosticHint",    { fg = "${c.cyan}" })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "${c.red}" })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = "${c.yellow}" })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = "${c.green}" })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = "${c.cyan}" })

      ${allConfig}
    '';
  };

  home.packages = allDeps;
}
