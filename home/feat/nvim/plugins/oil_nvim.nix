{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ oil-nvim mini-icons ];
  config = ''
    require("oil").setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    })
  '';
}
