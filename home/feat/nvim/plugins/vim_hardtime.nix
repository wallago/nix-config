{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ vim-hardtime ];
  config = ''
    require("hardtime").setup()
  '';
}
