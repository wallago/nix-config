{
  flake.homeModules.nvimPluginKulala =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = kulala-nvim;
          config = builtins.readFile ./setup.lua;
        }
      ];
    };
}
