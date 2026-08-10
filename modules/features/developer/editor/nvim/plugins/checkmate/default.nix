{
  flake.homeModules.nvimPluginCheckmate =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = checkmate-nvim;
          config = builtins.readFile ./setup.lua;
        }
      ];
    };
}
