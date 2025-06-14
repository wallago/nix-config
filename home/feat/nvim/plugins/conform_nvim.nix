{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ conform-nvim ];
  config = ''
    require("conform").setup({
    	formatters_by_ft = {
    		json = { "prettier" },
        yaml = { "yamlfmt" },
    		markdown = { "prettier" },
        rust = { "rustfmt", lsp_format = "fallback" },
        typescript = { "prettier" },
        javascript = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        sql = { "sql-formatter" },
        http = { "kulala" },
    	},
      formatters = {
        ["sql-formatter"] = {
          command = "sql-formatter",
          args = { "" },
          stdin = true,
        },
        kulala = {
          command = "kulala-fmt",
          args = { "format", "$FILENAME" },
          stdin = false,
        }
      },
    	format_on_save = {
    		enabled = true,
    		timeout_ms = 1000,
    		lsp_format = "fallback",
    		callback = function(bufnr, result)
    			require("notify")("File formatted successfully: " .. result, "info")
    		end,
    	},
    	notify_on_error = true,
    	notify_no_formatters = true,
    })
  '';
  deps = with pkgs; [ nodePackages.prettier yamlfmt sql-formatter kulala-fmt ];
}

