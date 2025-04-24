{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ inc-rename-nvim ];
  config = ''
    require("inc_rename").setup({})
  '';
}
