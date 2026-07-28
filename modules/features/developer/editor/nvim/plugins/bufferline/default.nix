{
  flake.homeModules.nvimPluginBufferline =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        nvim-web-devicons
        {
          plugin = bufferline-nvim;
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
