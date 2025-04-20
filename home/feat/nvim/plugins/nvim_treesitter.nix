{pkgs}: {
  plugin = pkgs.vimPlugins.nvim-treesitter;
  config = ''
    require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        parser_install_dir = vim.fn.stdpath("data") .. "/parsers",
        highlight = {
            enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            autotag = {
                enable = true, -- for HTML-like tags
            },
    })
  '';
}
