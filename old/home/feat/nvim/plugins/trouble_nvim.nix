{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ trouble-nvim ];
  config = ''
    require("trouble").setup({})
  '';
}
