{
  flake.homeModules.nvimPluginTelescope =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = telescope-nvim;
          config = builtins.concatStringsSep "\n" (
            map builtins.readFile [
              ./setup.lua
              ./binds.lua
            ]
          );
        }
        nvim-web-devicons
        telescope-fzf-native-nvim
        telescope-symbols-nvim
        telescope-media-files-nvim
      ];
      home.packages = with pkgs; [
        ripgrep
        fd
      ];
    };
}
