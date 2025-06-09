{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ rustaceanvim ];
  config = ''
    vim.g.rustaceanvim = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
              experimental = {
                enable = true,
              },
            },
          },
        },
      },
    }
  '';
}
