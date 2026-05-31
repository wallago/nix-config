{
  flake.homeModules.nvimPluginTabs =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        nvim-web-devicons
        {
          plugin = bufferline-nvim;
          config = ''
            require("bufferline").setup({
              highlights = require("catppuccin.special.bufferline").get_theme(),
              options = {
                mode = "tabs",
                diagnostics = "nvim_lsp",  -- show LSP errors/warnings on tabs
                separator_style = "slant", -- "thin" | "thick" | "slant" | "padded_slant"
                show_buffer_close_icons = close,
                show_close_icon = false,
                offsets = {
                  { 
                    filetype = "oil", 
                    text = "Files", 
                    highlight = "Directory" 
                  },
                },
              },
            })
          '';
        }
      ];
    };
}
