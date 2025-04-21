{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ which-key-nvim ];
  config = ''
    local wk = require("which-key")
    wk.add({
      { "<leader>f", group = "file" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
      { "<leader>fb", function() print("hello") end, desc = "Foobar" },
      { "<leader>fn", desc = "New File" },
      { "<leader>f1", hidden = true },
      { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
      { "<leader>b", group = "buffers", expand = function()
          return require("which-key.extras").expand.buf()
        end
      },
      {
        mode = { "n", "v" }, 
        { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
        { "<leader>w", "<cmd>w<cr>", desc = "Write" },
      }
    })
  '';
}
