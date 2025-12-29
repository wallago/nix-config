{ pkgs, config }:
let nav = config.keymap.nav;
in {
  plugins = with pkgs.vimPlugins; [ which-key-nvim ];
  config = ''
    -- Set leader key
    vim.g.mapleader = " "

    local wk = require("which-key")
    wk.setup {}
    wk.add({
      -- General
      { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
      { "<leader>z", "<cmd>Rest run<cr>", desc = "Request HTTP" },

      -- Miscellaneous
      { "<leader>m", "<cmd>MarkdownPreviewToggle<cr>", desc = "Open web page for markdown preview" },
      { "<leader>s", "<cmd>'<,'>sort<cr>", desc = "Sort selected stuff", mode = "v" },

      -- Oil
      { "<leader>r", group = "Oil" },
      { "<leader>od", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<leader>or", "<C-l>", desc = "refresh directories" },
      { "<leader>oc", "<C-c>", desc = "close directories" },

      -- Git
      { "<leader>g", "<cmd>Neogit<cr>", desc = "Git" },

      -- File
      { "<leader>f", group = "file" },
      { "<leader>fb", function() print("hello") end, desc = "Foobar" },
      { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find word" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files", mode = "n" },
      { "<leader>fs", "<cmd>w<cr>", desc = "Save File" },
      { "<leader>fS", "<cmd>wa<cr>", desc = "Save All Files" },
      { "<leader>fe", "<cmd>Ex<cr>", desc = "File Explorer", mode = "n" },
      { "<leader>fq", "<cmd>q<cr>", desc = "Quit File" },

      -- Buffers
      { "<leader>b", group = "buffers" },
      { "<leader>bn", "<cmd>bn<cr>", desc = "Next Buffer" },
      { "<leader>bp", "<cmd>bp<cr>", desc = "Previous Buffer" },
      { "<leader>bd", "<cmd>bd<cr>", desc = "Delete Buffer" },
      { "<leader>bl", "<cmd>Telescope buffers<cr>", desc = "Lists Buffers", mode = "n" },

      -- Window
      { "<leader>w", proxy = "<c-w>", group = "windows" },
      { "<leader>n", "<C-w>${nav.left}", desc = "Move to Left Window" },
      { "<leader>e", "<C-w>${nav.down}", desc = "Move to Below Window" },
      { "<leader>i", "<C-w>${nav.up}", desc = "Move to Above Window" },
      { "<leader>o", "<C-w>${nav.right}", desc = "Move to Right Window" },

      -- LSP
      { "<leader>p", group = "LSP" },
      { "<leader>pd", "<cmd>Lspsaga peek_definition<cr>", desc = "LSP Definition" },
      { "<leader>pt", "<cmd>Lspsaga peek_type_definition<cr>", desc = "LSP Type Definition" },
      { "<leader>pf", "<cmd>Lspsaga finder<cr>", desc = "LSP Finder" },
      -- { "<leader>ph", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "LSP Hover" },
      { "<leader>ph", "<cmd>Lspsaga hover_doc<cr>", desc = "LSP Hover" },
      { "<leader>pn", ":IncRename ", desc = "LSP Rename" },
      { "<leader>pa", require("actions-preview").code_actions, desc = "LSP Code Actions" },
      { "<leader>po", "<cmd>Lspsaga outline<cr>", desc = "LSP Outline" },
      
      -- Trouble
      { "<leader>x", group = "Trouble" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP" },

      -- Rust
      { "<leader>r", group = "Rust" },
      { "<leader>rr", "<cmd>RustAnalyzer restart<cr>", desc = "Diagnostics" },

      -- Spectre
      { "<leader>S", group = "Spectre" },
      { "<leader>St", "<cmd>lua require('spectre').toggle()<cr>", desc = "Toggle Spectre" },
      { "<leader>Sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", desc = "Search current word" },
      { "<leader>Sp", "<cmd>lua require('spectre').open_file({select_word=true})<cr>", desc = "Search current word" },
    })
  '';
}
