{
  config,
  pkgs,
  keymap,
  ...
}:
let
  inherit (config) colorscheme;
  hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors);
  c = colorscheme.colors;

  rawPluginModules = [
    # === LSP & Syntax ===
    ./plugins/nvim_lspconfig.nix # LSP client configuration
    ./plugins/nvim_treesitter.nix # Syntax highlighting & code parsing
    ./plugins/conform_nvim.nix # Code formatting on save
    ./plugins/nvim_cmp.nix # Autocompletion engine
    ./plugins/lspsaga_nvim.nix # Enhanced LSP UI (hover, rename, code actions)

    # === Navigation & Search ===
    ./plugins/telescope_nvim.nix # Fuzzy finder (files, grep, buffers)
    ./plugins/oil_nvim.nix # File explorer as a buffer

    # === Diagnostics & Errors ===
    ./plugins/trouble_nvim.nix # Pretty diagnostics/quickfix panel
    ./plugins/todo_comments_nvim.nix # Highlight & list TODO/FIXME/HACK comments

    # === UI Enhancements ===
    ./plugins/nvim_colorizer_lua.nix # Inline color preview (#fff, rgb())
    ./plugins/nvim_web_devicons.nix # File type icons
    ./plugins/bufferline_nvim.nix # Tab-style buffer bar
    ./plugins/indent_blankline_nvim.nix # Indentation guides
    ./plugins/neovim_tips.nix # Startup tips/tricks
    ./plugins/fidget_nvim.nix # Extensible UI for notif and LSP progress messages

    # === Editing ===
    ./plugins/nvim_autopairs.nix # Auto-close brackets/quotes
    ./plugins/yanky_nvim.nix # Yank ring / clipboard history
    ./plugins/neoscroll_nvim.nix # Smooth scrolling
    ./plugins/nvim_ufo.nix # Enhanced code folding
    ./plugins/hunk_nvim.nix # Side-by-side diff viewer
    ./plugins/jj_diffconflicts_nvim.nix # Merge tool for JJ

    # === Language-Specific ===
    ./plugins/rustaceanvim.nix # Rust-analyzer integration & extras
    ./plugins/mermaid_nvim.nix # Mermaid diagram preview
    ./plugins/kulala_nvim.nix # HTTP client (like Postman in nvim)

    # === VCS & Debug ===
    ./plugins/jj_nvim.nix # Jujutsu version control integration
    ./plugins/nvim_dap.nix # Debug adapter (breakpoints, stepping)
  ];

  rawPluginColorModules = [
    ./plugins/lualine_nvim.nix # Statusline
    ./plugins/nvim_notify.nix # Popup notification UI
    ./plugins/alpha_nvim.nix # Dashboard / start screen
  ];

  rawPluginKeymapingModules = [ ./plugins/which_key_nvim.nix ];

  pluginModules =
    (map (file: import file { inherit pkgs; }) rawPluginModules)
    ++ map (file: import file { inherit pkgs c; }) rawPluginColorModules
    ++ map (file: import file { inherit pkgs keymap; }) rawPluginKeymapingModules;

  getOrDefault =
    name: default: module:
    if builtins.hasAttr name module then module.${name} else default;

  allPlugins = builtins.concatLists (map (m: m.plugins) pluginModules);
  allExtraLuaPackages =
    ps: builtins.concatLists (map (m: (getOrDefault "extraLuaPackages" (_: [ ]) m) ps) pluginModules);
  allDeps = builtins.concatLists (map (m: getOrDefault "deps" [ ] m) pluginModules);
  allConfig = builtins.concatStringsSep "\n" (map (m: getOrDefault "config" "" m) pluginModules);

  general = builtins.readFile ./lua/general.lua;
  remapping = builtins.readFile ./lua/remapping.lua;
  spell_completion = builtins.readFile ./lua/spell_completion.lua;
  diagnostic = builtins.readFile ./lua/diagnostic.lua;
  theme = ''
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
  '';
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    COLORTERM = "truecolor";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins =
      allPlugins
      ++ (with pkgs.vimPlugins; [
        # Essential
        vim-commentary

        # Useful
        markdown-preview-nvim
      ]);
    extraLuaPackages = allExtraLuaPackages;
    initLua = ''
      ${general}
      ${spell_completion}
      ${diagnostic}
      ${theme}
      ${allConfig}
      ${remapping}
    '';
  };

  home.packages = allDeps;
}
