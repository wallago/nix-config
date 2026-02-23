{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ nvim-autopairs ];
  config = ''
    require('nvim-autopairs').setup({
    })
  '';
}
