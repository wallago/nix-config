{
  flake.homeModules.nvimPluginScope =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = scope-nvim;
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
