{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ indent-blankline-nvim ];
  config = ''
    require('ibl').setup({
    })
  '';
}
