{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ neoscroll-nvim ];
  config = ''
    require('neoscroll').setup()
  '';
}
