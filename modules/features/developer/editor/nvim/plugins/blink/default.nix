{
  flake.homeModules.nvimPluginBlink =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = blink-cmp;
          config = builtins.concatStringsSep "\n" (
            map builtins.readFile [
              ./setup.lua
              ./binds.lua
            ]
          );
        }
      ];
    };
}
