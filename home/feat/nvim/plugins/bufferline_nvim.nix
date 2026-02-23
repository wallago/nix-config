{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ bufferline-nvim ];
  config = ''
    require('bufferline').setup({
    })
  '';
}
