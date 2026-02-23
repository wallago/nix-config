{ pkgs }:
let
  left = "n";
  right = "o";
  up = "i";
  down = "e";
  # nav = keymap.nav;
  # left = nav.left;
  # right = nav.right;
  # up = nav.up;
  # down = nav.down;
in
{
  plugins = with pkgs.vimPlugins; [
    alpha-nvim
  ];
  config = ''
    local pages = {
      {
        "╭──────────────────────────────────────────────────────────────────╮",
        "│                     Navigation  [1/3]                            │",
        "╰──────────────────────────────────────────────────────────────────╯",
        "",
        "  ${left}/${down}/${up}/${right}        ←↓↑→ cursor                  ",
        "  w              next word start       f          next word end      ",
        "  b              prev word start       p          prev word end      ",
        "  0              start of line         $          end of line        ",
        "  ^              first non-blank       g_         last non-blank     ",
        "  gg             first line            G          last line          ",
        "  {num}G         go to line            {num}+${down}/${up}  move to line ↓/↑   ",
        "  %              matching bracket      Ctrl+${down}/${up}   scroll line ↓/↑    ",
        "  Ctrl+d/u       half page ↓/↑         Ctrl+f/b   full page ↓/↑      ",
        "  H/M/L          top/mid/bot screen    zz/zt/zb   center/top/bot     ",
        "  (/)            sentence prev/next    {/}        paragraph p/n      ",
      },
      {
        "╭──────────────────────────────────────────────────────────────────╮",
        "│                    Insert Mode  [X/X]                            │",
        "╰──────────────────────────────────────────────────────────────────╯",
        "",
        "  Entering Insert Mode                                            ",
        "  ───────────────────────────────────────────────────────────── ",
        "  s/S            insert before cursor / at bol                   ",
        "  a/A            append after cursor / at eol                     ",
        "  r/R            open new line below / above                      ",
        "  ga             append at end of word                            ",
        "  gi             insert at last insert position                   ",
        "",
        "  While in Insert Mode                                            ",
        "  ───────────────────────────────────────────────────────────── ",
        "  Ctrl+h         delete char before cursor                        ",
        "  Ctrl+w         delete word before cursor                        ",
        "  Ctrl+u         delete line before cursor                        ",
        "  Ctrl+t         indent line                                      ",
        "  Ctrl+d         un-indent line                                   ",
        "  Ctrl+r {reg}   insert from register                             ",
      },
    }

    local current_page = 1

    local cheatsheet = {
      type = "text",
      val = function()
        return pages[current_page]
      end,
      opts = {
        position = "center",
        hl = "Comment",
      },
    }

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

    local hint = {
      type = "text",
      val = "  Tab / Shift+Tab to cycle cheatsheet pages",
      opts = {
        position = "center",
        hl = "AlphaFooter",
      },
    }

    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      hint,
      { type = "padding", val = 1 },
      cheatsheet,
    }

    alpha.setup(dashboard.config)
  '';
}
