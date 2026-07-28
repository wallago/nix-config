{
  flake.homeModules.nvimPluginOil =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = oil-nvim;
          config = builtins.concatStringsSep "\n" (
            map builtins.readFile [
              ./setup.lua
              ./binds.lua
            ]
          );
        }
        mini-icons
        nvim-web-devicons
      ];
    };
}
