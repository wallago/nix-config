{
  flake.homeModules.nvimPluginBufferline =
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

            -- Most used functions
            vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>")
            vim.keymap.set("n", "<leader>bf", "<cmd>BufferLineCycleNext<CR>")
            vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<CR>")
          '';
        }
      ];
    };
}
