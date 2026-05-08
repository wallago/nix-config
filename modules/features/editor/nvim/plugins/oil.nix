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
          '';
        }
        mini-icons
        nvim-web-devicons
      ];
    };
}
