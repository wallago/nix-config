{
  flake.homeModules.nvimPluginTips =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = neovim-tips;
          config = builtins.concatStringsSep "\n" (
            map builtins.readFile [
              ./setup.lua
              ./binds.lua
            ]
          );
        }
        render-markdown-nvim
        nui-nvim
      ];
    };
}
