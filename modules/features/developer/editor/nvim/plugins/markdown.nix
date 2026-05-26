{
  flake.homeModules.nvimPluginMarkdown =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = render-markdown-nvim;
          config = ''
            require("render-markdown").setup({
              completions = { lsp = { enabled = true } },
            })
          '';
        }
        {
          plugin = markdown-preview-nvim;
          config = ''
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_theme = "dark"
          '';
        }
      ];
    };
}
