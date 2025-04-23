{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ nvim-notify ];
  config = ''
    vim.notify = require("notify")
  '';
}
