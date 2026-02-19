{ pkgs, keymap }:
let
  nav = keymap.nav;
in
{
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
      { "<leader>rd", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<leader>rr", "<C-l>", desc = "refresh directories" },
      { "<leader>rc", "<C-c>", desc = "close directories" },

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
      { "<leader>${nav.left}", "<C-w>h", desc = "Move to Left Window" },
      { "<leader>${nav.down}", "<C-w>j", desc = "Move to Below Window" },
      { "<leader>${nav.up}", "<C-w>k", desc = "Move to Above Window" },
      { "<leader>${nav.right}", "<C-w>l", desc = "Move to Right Window" },

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
      { "<leader>z", group = "Rust" },
      { "<leader>zr", "<cmd>RustAnalyzer restart<cr>", desc = "Diagnostics" },

      -- Jujutsu
      { "<leader>j", group = "Jujutsu" },
      { "<leader>jd", "<cmd>J desc<cr>", desc = "Description" },
      { "<leader>jl", "<cmd>J st<cr>", desc = "Status" },
      { "<leader>jl", "<cmd>J log<cr>", desc = "Log" },
      { "<leader>j=", "<cmd>J diff<cr>", desc = "Diff" },
      { "<leader>jn", "<cmd>J new<cr>", desc = "New" },
      { "<leader>je", "<cmd>J edit<cr>", desc = "Edit" },
      { "<leader>js", "<cmd>J squash<cr>", desc = "Squash" },
      { "<leader>j/", "<cmd>J splite<cr>", desc = "Splite" },
      { "<leader>jr", "<cmd>J rebase<cr>", desc = "Rebase" },
      { "<leader>j<", "<cmd>J undo<cr>", desc = "Undo" },
      { "<leader>j>", "<cmd>J redo<cr>", desc = "Redo" },
      { "<leader>jc", "<cmd>J commit<cr>", desc = "Commit" },
      { "<leader>jb", group = "Bookmark" },
      { "<leader>jbc", "<cmd>J bookmark create<cr>", desc = "Create" },
      { "<leader>jbd", "<cmd>J bookmark delete<cr>", desc = "Delete" },
      { "<leader>jt", group = "Tag" },
      { "<leader>jts", "<cmd>J tag set<cr>", desc = "Set" },
      { "<leader>jtd", "<cmd>J tag delete<cr>", desc = "Delete" },
      { "<leader>jtp", "<cmd>J tag push<cr>", desc = "Push" },

      -- Spectre
      { "<leader>S", group = "Spectre" },
      { "<leader>St", "<cmd>lua require('spectre').toggle()<cr>", desc = "Toggle Spectre" },
      { "<leader>Sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", desc = "Search current word" },
      { "<leader>Sp", "<cmd>lua require('spectre').open_file({select_word=true})<cr>", desc = "Search current word" },
    })
  '';
}
