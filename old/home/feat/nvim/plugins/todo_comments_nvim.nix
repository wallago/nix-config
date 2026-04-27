{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ todo-comments-nvim ];
}
