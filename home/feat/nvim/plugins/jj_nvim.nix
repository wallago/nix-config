{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ jj-nvim ];
  config = ''
    require("jj").setup({})
  '';
}
