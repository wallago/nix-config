{
  flake.homeModules.nvimPluginConform =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = conform-nvim;
          config = ''
            require("conform").setup({
              formatters_by_ft = {
                lua = { "stylua" },
                nix = { "nixfmt" },
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
                toml = { "taplo" },
                python = { "black" },
                just = { "just" }
              },
              formatters = {
                ["sql-formatter"] = {
                  command = "sql-formatter",
                  args = { "" },
                  stdin = true,
                },
              },
              format_on_save = {
                enabled = true,
                timeout_ms = 5000,
                notify_on_error = true,
                notify_no_formatters = true,
                lsp_format = "fallback",
                callback = function(bufnr, result)
                  require("notify")("File formatted successfully: " .. result, "info")
                end,
              },
              notify_on_error = true,
              notify_no_formatters = true,
            })
          '';
        }
      ];

      home.packages = with pkgs; [
        nixfmt
        prettier
        yamlfmt
        rustfmt
        stylua
        sql-formatter
        kulala-fmt
        taplo
        black
        jq
        libxml2
        just
      ];
    };
}
