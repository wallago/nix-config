{
  flake.homeModules.nvimPluginActionsPreview =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = actions-preview-nvim;
          config = builtins.readFile ./binds.lua;
        }
        snacks-nvim
        mini-nvim
        telescope-nvim
        nui-nvim
      ];
    };
}
