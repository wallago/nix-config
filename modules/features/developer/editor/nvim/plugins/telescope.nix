{
  flake.homeModules.nvimPluginTelescope =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = telescope-nvim;
          config = ''
            require("telescope").setup({
              defaults = {
                mappings = {
                  i = {
                    ["<C-e>"] = require("telescope.actions").move_selection_next,
                    ["<C-i>"] = require("telescope.actions").move_selection_previous,
                  },
                },
              },
            })

            require("telescope").load_extension("yank_history")

            local map = vim.keymap.set
            map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
            map("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", { desc = "Grep project" })
            map("n", "<leader>fb", "<CMD>Telescope buffers<CR>", { desc = "Buffers" })
            map("n", "<leader>fh", "<CMD>Telescope help_tags<CR>", { desc = "Help" })
            map("n", "<leader>fr", "<CMD>Telescope resume<CR>", { desc = "Resume last picker" })
            map("n", "<leader>fk", "<CMD>Telescope keymaps<CR>", { desc = "Keymaps" })
            map("n", "<leader>/", "<CMD>Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in buffer" })
            map("n", "<leader>p", "<CMD>Telescope yank_history<CR>", { desc = "Paste from history" })
          '';
        }
        nvim-web-devicons
        telescope-fzf-native-nvim
      ];
      home.packages = with pkgs; [
        ripgrep
        fd
      ];
    };
}
