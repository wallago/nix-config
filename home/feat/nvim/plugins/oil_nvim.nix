{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    oil-nvim
    mini-icons
  ];
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
