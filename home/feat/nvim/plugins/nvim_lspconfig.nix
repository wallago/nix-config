{pkgs}: {
  plugin = pkgs.vimPlugins.nvim-lspconfig;
  config = ''
    local lspconfig = require('lspconfig')

    vim.lsp.config('rust_analyzer', {
         settings = {
             ['rust-analyzer'] = {},
         },
    })

    vim.lsp.config('nil_ls', {
         settings = {
             ['nil'] = {
                 formatting = {
                     command = { "alejandra" }
                 },
                 nix = {
                     flake = {
                         autoArchive = true,
                     },
                 }
             }
         },
     	on_attach = function(client, bufnr)
             -- Format on save
             if client.server_capabilities.documentFormattingProvider then
                 vim.api.nvim_create_autocmd("BufWritePre", {
                     group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
     				buffer = bufnr,
     				callback = function()
     					vim.lsp.buf.format({ async = false })
     				end,
     			})
     		end
     	end,
     	capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
  '';
}
