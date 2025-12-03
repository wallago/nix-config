{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ nvim-spectre ];
  config = ''
    require('spectre').setup({})
  '';
}
