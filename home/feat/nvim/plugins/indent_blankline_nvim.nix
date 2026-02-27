{ pkgs, c }:
{
  plugins = with pkgs.vimPlugins; [ indent-blankline-nvim ];
  config = ''
    local highlight = {
      "CursorColumn",
      "Whitespace",
    }

    require("ibl").setup { 
      indent = { highlight = highlight, char = "" },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      scope = { enabled = false }, 
    }
  '';
}
