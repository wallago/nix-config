{
  flake.homeModules.nvimPluginOil =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = oil-nvim;
          config = ''
            require("oil").setup({
                default_file_explorer = true,
                skip_confirm_for_simple_edits = true,
                win_options = {
                    wrap = true,
                },
                view_options = {
                    show_hidden = true,
                    natural_order = true,
                    is_always_hidden = function(name, _)
                        return name == '..' or name == '.git' or name == '.jj'
                    end
                },
            })

            local map = vim.keymap.set
            map("n", "-","<CMD>Oil<CR>", { desc = "Oil: parent dir" })
            map("n", "<leader>-", "<CMD>Oil --float<CR>", { desc = "Oil: floating window" })
            map("n", "<leader>fe", "<CMD>Oil<CR>", { desc = "File explorer (Oil)" })
          '';
        }
        mini-icons
        nvim-web-devicons
      ];
    };
}
