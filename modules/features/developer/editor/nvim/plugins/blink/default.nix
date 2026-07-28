{
  flake.homeModules.nvimPluginBlink =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = blink-cmp;
          config = builtins.readFile ./setup.lua;
        }
      ];
    };
}
