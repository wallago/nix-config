{ pkgs, c }:
{
  plugins = with pkgs.vimPlugins; [
    alpha-nvim
  ];
  config = ''
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        local alpha = require("alpha")
        vim.keymap.set("n", "<Tab>", function()
          current_page = current_page % #pages + 1
          alpha.redraw()
        end, { buffer = true, silent = true })

        vim.keymap.set("n", "<S-Tab>", function()
          current_page = (current_page - 2) % #pages + 1
          alpha.redraw()
        end, { buffer = true, silent = true })
      end,
    })

    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                                    ]],
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
      [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    }
    dashboard.section.header.opts.hl = "AlphaHeader"

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file",       ":Telescope find_files<CR>"),
      dashboard.button("r", "  Recent files",    ":Telescope oldfiles<CR>"),
      dashboard.button("g", "  Live grep",       ":Telescope live_grep<CR>"),
      dashboard.button("n", "  New file",        ":ene <BAR> startinsert<CR>"),
      dashboard.button("q", "  Quit",            ":qa<CR>"),
    }

    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
    }

    alpha.setup(dashboard.config)

    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = '${c.primary}', bold = true })
    vim.api.nvim_set_hl(0, "AlphaButtons", { fg = '${c.on_surface}' })

  '';
}
