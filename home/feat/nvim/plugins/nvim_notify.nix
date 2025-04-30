{ pkgs, c }: {
  plugins = with pkgs.vimPlugins; [ nvim-notify ];
  config = ''
    vim.notify = require("notify")

    require("notify").setup({
      stages = "fade_in_slide_out",
      background_colour = "${c.surface}",
      timeout = 3000,
      render = "compact",
      max_width = 60,
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
