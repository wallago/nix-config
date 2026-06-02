{
  flake.homeModules.nvimPluginNeorg =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = neorg;
          config = ''
            require("neorg").setup({
              load = {
                ["core.defaults"] = {},         -- sane base modules
                ["core.concealer"] = {},        -- pretty icons / folding
                ["core.qol.todo_items"] = {},   -- <C-Space> cycles task state
                ["core.summary"] = {            -- :Neorg generate-workspace-summary → auto index of all TODOs
                  config = { strategy = "flat" },
                },
              },
            })
          '';
        }
      ];
    };
}
