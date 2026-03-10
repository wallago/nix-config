{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ lspsaga-nvim ];
  config = ''
    require('lspsaga').setup({
      ui = {
        border = "rounded",
        code_action = "🔧",
        diagnostic = "📣",
        devicon = true,
        title = true,
        expand = '🔽',
        collapse = '🔼',
        actionfix = '🪛',
        imp_sign = '⏩',
      },
      lightbulb = {
        enable = true,
        sign = true,        
        virtual_text = false,
      },
      symbol_in_winbar = {
        enable = true,
        separator = ' > '
      }
    })
  '';
}

