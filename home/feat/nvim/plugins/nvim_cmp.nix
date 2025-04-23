{ pkgs }: {
  plugins = with pkgs.vimPlugins; [
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp-nvim-lsp-signature-help
    cmp-nvim-lua
    luasnip
  ];
  config = ''
    local cmp = require'cmp'
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = 'render-markdown' },
        { name = "path" },
        { name = "buffer" },
        { name = "calc" },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
            local menu_icon ={
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
      }
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
          { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })
  '';
}
