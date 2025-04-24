{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ smear-cursor-nvim ];
  config = ''
    require("smear_cursor").setup({})
  '';
}

