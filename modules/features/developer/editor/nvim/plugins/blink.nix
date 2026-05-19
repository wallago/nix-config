{
  flake.homeModules.nvimPluginBlink =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = blink-cmp;
          config = ''
            require("blink.cmp").setup({
              -- "default" = <C-space> open, <C-y> accept, <C-n>/<C-p> navigate.
              -- Use "enter" if you want <CR> to confirm (matches your old cmp habit).
              keymap = { preset = "enter" },

              appearance = { nerd_font_variant = "mono" },

              sources = {
                default = { "lsp", "path", "snippets", "buffer" },
              },

              completion = {
                menu = { auto_show = true },                 -- popup as you type
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
                ghost_text = { enabled = true },
              },

              signature = { enabled = true },                -- replaces cmp-nvim-lsp-signature-help
            })
          '';
        }
      ];
    };
}
