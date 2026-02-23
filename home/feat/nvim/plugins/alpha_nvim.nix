{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ alpha-nvim ];
  config = ''
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    alpha.setup(dashboard.config)
  '';
}
