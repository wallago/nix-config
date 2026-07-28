{
  flake.homeModules.nvimPluginDap =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        nvim-nio
        {
          plugin = nvim-dap;
          config = builtins.concatStringsSep "\n" (
            map builtins.readFile [
              ./setup.lua
              ./binds.lua
            ]
          );
        }
        {
          plugin = nvim-dap-ui;
          config = builtins.concatStringsSep "\n" (
            map builtins.readFile [
              ./setup-ui.lua
              ./binds-ui.lua
            ]
          );
        }
      ];
    };
}
