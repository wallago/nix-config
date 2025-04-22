{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ conform-nvim ];
  config = ''
    require("conform").setup({
    	formatters_by_ft = {
    		json = { "prettier" },
    		yaml = { "prettier" },
    		markdown = { "prettier" },
    	},
    	format_on_save = {
    		enabled = true,
    		timeout_ms = 1000,
    		lsp_format = "fallback",
    		callback = function(bufnr)
    			require("notify")("File formatted successfully: " .. result, "info")
    		end,
    	},
    	notify_on_error = true,
    	notify_no_formatters = true,
    })
  '';
  deps = with pkgs; [ nodePackages.prettier ];
}

