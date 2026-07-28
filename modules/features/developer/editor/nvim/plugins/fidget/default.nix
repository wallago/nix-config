{
  flake.homeModules.nvimPluginFidget =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = fidget-nvim;
          config = builtins.readFile ./setup.lua;
        }
      ];
    };
}
