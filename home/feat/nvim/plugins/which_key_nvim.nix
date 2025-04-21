{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ which-key-nvim ];
  config = ''
    -- Set leader key
    vim.g.mapleader = " "

    local wk = require("which-key")
    wk.setup {}
    wk.add({
      -- Miscellaneous
      { "<leader>q", "<cmd>q<cr>", desc = "Quit" },

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
      { "<leader>h", "<C-w>h", desc = "Move to Left Window" },
      { "<leader>j", "<C-w>j", desc = "Move to Below Window" },
      { "<leader>k", "<C-w>k", desc = "Move to Above Window" },
      { "<leader>l", "<C-w>l", desc = "Move to Right Window" },

      -- LSP
      { "<leader>l", proxy = "gr", group = "LSP" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "LSP References" },
      { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "LSP Definition" },
      { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "LSP Hover" },
    })
  '';
}
