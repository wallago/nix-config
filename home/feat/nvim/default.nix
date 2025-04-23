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
    ./plugins/conform_nvim.nix
    ./plugins/nvim_web_devicons.nix
    ./plugins/gitsigns_nvim.nix
    ./plugins/trouble_nvim.nix
    ./plugins/lualine_nvim.nix
    ./plugins/noice_nvim.nix
    ./plugins/nvim_notify.nix
    ./plugins/render_markdown_nvim.nix
    ./plugins/rustaceanvim.nix
    ./plugins/inc_rename_nvim.nix
    ./plugins/actions_preview_nvim.nix
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
      # stand alone
      rustaceanvim
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
      vim.opt.completeopt = { 
        "menu", -- use a popup menu to show the possible completions 
        "menuone", -- use the popup menu also when there is only one match
        "noselect", -- except that no menu item is pre-selected
        "noinsert", -- do not insert any text for a match until the user selects a match from the menu
      }
      -- Miscellaneous

      -- Diagnostic 
      local function define_diagnostic_sign(name, icon)
        vim.fn.sign_define(name, {
          text = icon,
          texthl = name,
          numhl = ""
        })
      end

      define_diagnostic_sign("DiagnosticSignError", "󰅚")
      define_diagnostic_sign("DiagnosticSignWarn",  "󰗖")
      define_diagnostic_sign("DiagnosticSignHint",  "󰌶")
      define_diagnostic_sign("DiagnosticSignInfo",  "󰋽")

      vim.diagnostic.config({
        signs = true,
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
      ${allConfig}
    '';
  };

  home.packages = allDeps;
}

#     toggleterm-nvim # -------> floating terminal
#     vim-dadbod-ui # ---------> navigation database gui
#     oil-nvim # --------------> file explorer that lets you edit your filesystem like a normal Neovim buffer.
#     openscad-nvim # --------->
#     vim-nix # ---------------> writing Nix expressions
#     markdown-nvim # ---------> beautify markdown
#     markdown-preview-nvim # -> preview markdown file
#     rest-nvim # -------------> asynchronous Neovim HTTP client
#     vim-flog # --------------> git graph
#     fugitive # --------------> git commands
#     lazygit-nvim # ----------> git interface
#     bufferline-nvim # -------> tabs behavior
#     nvim-colorizer-lua # ----> show color by code
#     nvim-tree-lua # ---------> file explorer

#   luajit # ----------------> Just-In-Time compiler for Lua programming language
#   isort # -----------------> Python utility to sort imports alphabetically
#   black # -----------------> The uncompromising Python code formatter
