{
  flake.homeModules.nvimPluginActionsPreview =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = actions-preview-nvim;
          config = ''
            vim.keymap.set({ "v", "n" }, "ga", require("actions-preview").code_actions)
          '';
        }
        snacks-nvim
        mini-nvim
        telescope-nvim
        nui-nvim
      ];
    };
}
