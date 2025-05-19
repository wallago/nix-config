{ pkgs, c }: {
  plugins = with pkgs.vimPlugins; [ nvim-notify ];
  config = ''
    vim.notify = require("notify")

    require("notify").setup({
      stages = "fade_in_slide_out",
      background_colour = "${c.surface}",
      timeout = 3000,
      render = "compact",
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    })
  '';
}
