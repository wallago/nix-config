{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ hunk-nvim ];
  config = ''
    require("hunk").setup()
  '';
}
