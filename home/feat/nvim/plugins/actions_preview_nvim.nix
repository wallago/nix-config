{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ actions-preview-nvim ];
  config = ''
    require("actions-preview").setup({})
  '';
}
