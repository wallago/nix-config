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
  deps = with pkgs; [ rust-bin.nightly.latest.complete ];
}
