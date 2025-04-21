{ pkgs }: {
  plugins = with pkgs.vimPlugins; [
    nvim-treesitter
    nvim-treesitter-parsers.nix
    nvim-treesitter-parsers.lua
    nvim-treesitter-parsers.luadoc
    nvim-treesitter-parsers.vim
    nvim-treesitter-parsers.vimdoc
    nvim-treesitter-parsers.bash
    nvim-treesitter-parsers.fish
    nvim-treesitter-parsers.json
    nvim-treesitter-parsers.yaml
    nvim-treesitter-parsers.toml
    nvim-treesitter-parsers.rust
    nvim-treesitter-parsers.c
    nvim-treesitter-parsers.tsx
    nvim-treesitter-parsers.python
    nvim-treesitter-parsers.go
    nvim-treesitter-parsers.zig
    nvim-treesitter-parsers.html
    nvim-treesitter-parsers.css
    nvim-treesitter-parsers.gpg
    nvim-treesitter-parsers.dockerfile
    nvim-treesitter-parsers.gitattributes
    nvim-treesitter-parsers.gitcommit
    nvim-treesitter-parsers.gitignore
    nvim-treesitter-parsers.markdown
    nvim-treesitter-parsers.markdown_inline
    nvim-treesitter-parsers.latex
  ];
  config = ''
    require("nvim-treesitter.configs").setup({
      auto_install = true,
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
  deps = with pkgs; [ gcc ];
}
