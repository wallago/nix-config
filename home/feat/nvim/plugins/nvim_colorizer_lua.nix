{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ nvim-colorizer-lua ];
  config = ''
    require("colorizer").setup({})
  '';
}
