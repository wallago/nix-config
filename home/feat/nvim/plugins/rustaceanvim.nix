{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ rustaceanvim ];
  config = ''
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
              experimental = {
                enable = true,
              },
            },
            checkOnSave = true,
            numThreads = 4,
          },
        },
      },
    }
  '';
}
