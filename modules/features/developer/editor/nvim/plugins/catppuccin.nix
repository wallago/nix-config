{
  flake.homeModules.nvimPluginCatppuccin =
    { pkgs, ... }:
    {
      programs.neovim.plugins = [
        {
          plugin = pkgs.vimPlugins.catppuccin-nvim;
          config = ''
            require("catppuccin").setup({
              flavour = "mocha",
              integrations = {
                blink_cmp = {
                  style = 'bordered',
                },
                fidget = true,
                lualine = {
                  all = function(colors)
                    return {
                      normal = {
                        a = { bg = colors.blue,    fg = colors.mantle, gui = "bold" },
                        b = { bg = colors.surface0, fg = colors.blue },
                        c = { bg = "NONE",          fg = colors.text },
                      },
                      insert   = {
                        a = { bg = colors.green,  fg = colors.base, gui = "bold" },
                        b = { bg = colors.surface0, fg = colors.green },
                      },
                      terminal = {
                        a = { bg = colors.green,  fg = colors.base, gui = "bold" },
                        b = { bg = colors.surface0, fg = colors.green },
                      },
                      command  = {
                        a = { bg = colors.peach,  fg = colors.base, gui = "bold" },
                        b = { bg = colors.surface0, fg = colors.peach },
                      },
                      visual   = {
                        a = { bg = colors.mauve,  fg = colors.base, gui = "bold" },
                        b = { bg = colors.surface0, fg = colors.mauve },
                      },
                      replace  = {
                        a = { bg = colors.red,    fg = colors.base, gui = "bold" },
                        b = { bg = colors.surface0, fg = colors.red },
                      },
                      inactive = {
                        a = { bg = "NONE", fg = colors.blue },
                        b = { bg = "NONE", fg = colors.surface1, gui = "bold" },
                        c = { bg = "NONE", fg = colors.overlay0 },
                      },
                    }
                  end,
                },
                native_lsp = {
                  enabled = true,
                  underlines = {
                    errors      = { "undercurl" },
                    hints       = { "undercurl" },
                    warnings    = { "undercurl" },
                    information = { "undercurl" },
                  },
                },
                cmp = true,
                dap = true,
                dap_ui = true,
                notify = true,
                treesitter = true,
                treesitter_context = true,
                render_markdown = true,
                telescope = { enabled = true },
                lsp_trouble = true,
                which_key = true,
                oil = true,
              },
            })
            vim.cmd.colorscheme "catppuccin-nvim"

            local sign = vim.fn.sign_define

            sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
            sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
            sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})
          '';
        }
      ];
    };
}
