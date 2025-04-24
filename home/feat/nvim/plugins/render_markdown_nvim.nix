{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ render-markdown-nvim ];
  deps = with pkgs; [ python312Packages.pylatexenc ];
}
