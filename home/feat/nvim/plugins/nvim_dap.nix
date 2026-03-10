{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    nvim-dap
  ];
}
