{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ none-ls-nvim ];
  config = ''
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Code actions
        null_ls.builtins.code_actions.gitsigns,
      },
    })
  '';
}
