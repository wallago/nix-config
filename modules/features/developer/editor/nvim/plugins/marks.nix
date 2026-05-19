{
  flake.homeModules.nvimPluginMarks =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = marks-nvim;
          config = ''
            require("marks").setup({
              default_mappings = true, -- use plugin's built-in mappings
              builtin_marks = { ".", "<", ">", "^" }, -- show these auto-marks too
              cyclic = true, -- mx]/mx[ cycles around
              force_write_shada = false,
              refresh_interval = 250,
              sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
              excluded_filetypes = { "oil", "TelescopePrompt" },
              mappings = {
                -- override any default if needed; nil to unbind
              },
            })
          '';
        }
      ];
    };
}
