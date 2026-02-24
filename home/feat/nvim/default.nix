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
    # Essential
    ./plugins/nvim_lspconfig.nix
    ./plugins/nvim_treesitter.nix
    ./plugins/conform_nvim.nix
    ./plugins/nvim_cmp.nix
    ./plugins/telescope_nvim.nix
    ./plugins/lspsaga-nvim.nix

    # QOF
    ./plugins/oil_nvim.nix
    ./plugins/trouble_nvim.nix
    ./plugins/inc_rename_nvim.nix
    ./plugins/nvim_colorizer_lua.nix
    ./plugins/nvim_web_devicons.nix
    ./plugins/hunk_nvim.nix
    ./plugins/neoscroll_nvim.nix
    ./plugins/nvim_autopairs.nix
    ./plugins/bufferline_nvim.nix

    # Useful
    ./plugins/rustaceanvim.nix
    ./plugins/mermaid_nvim.nix
    ./plugins/rest-nvim.nix
    ./plugins/jj_nvim.nix
    ./plugins/nvim_spectre.nix

    # ./plugins/actions_preview_nvim.nix
  ];

  rawPluginColorModules = [
    # QOF
    ./plugins/lualine_nvim.nix
    ./plugins/nvim_notify.nix
    ./plugins/alpha_nvim.nix
    ./plugins/indent_blankline_nvim.nix
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
  spell_completion = builtins.readFile ./lua/spell_completion.lua;
  diagnostic = builtins.readFile ./lua/diagnostic.lua;
  cheatsheet = builtins.readFile ./lua/cheatsheet.lua;
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
      ${cheatsheet}
      ${allConfig}
    '';
  };

  home.packages = allDeps;
}
