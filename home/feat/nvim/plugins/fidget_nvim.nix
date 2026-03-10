{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ fidget-nvim ];
  config = ''
    require("fidget").setup({})
  '';
}
