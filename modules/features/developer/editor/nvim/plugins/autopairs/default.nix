{
  flake.homeModules.nvimPluginAutopairs =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-autopairs;
          config = builtins.readFile ./setup.lua;
        }
      ];
    };
}
