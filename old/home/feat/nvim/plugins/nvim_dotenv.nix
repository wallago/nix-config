{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ vim-dotenv ];
}
