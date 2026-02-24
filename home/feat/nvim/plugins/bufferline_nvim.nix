{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ bufferline-nvim ];
  config = ''
    require('bufferline').setup({
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        show_close_icon = false,
      }
    })
  '';
}
