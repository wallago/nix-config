{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ nvim-web-devicons ];
  config = ''
    require("nvim-web-devicons").setup({
      color_icons = true;
      default = true;
      strict = true;
    })
  '';
}

