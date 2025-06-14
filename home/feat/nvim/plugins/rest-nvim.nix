{ pkgs }: {
  plugins = with pkgs.vimPlugins; [ rest-nvim ];
  config = ''
    vim.cmd [[
      autocmd FileType json setlocal formatprg=jq
      autocmd FileType html setlocal formatprg=tidy\ -i\ -q
    ]]
  '';
  deps = with pkgs; [ luarocks jq html-tidy ];
}

