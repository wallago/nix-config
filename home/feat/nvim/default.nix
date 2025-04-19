{ config, pkgs, ... }:
let
  inherit (config) colorscheme;
  hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors);
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    COLORTERM = "truecolor";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      telescope-nvim
      lazy-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      gitsigns-nvim
      nvim-web-devicons
      which-key-nvim
    ];
  };
}



  #   withNodeJs = true;
  #   withRuby = true;
  #   withPython3 = true;
  #   extraConfig = ''
  #     ${builtins.readFile ./config.vim}
  #   '';
  #   plugins = with pkgs.vimPlugins; [
  #     toggleterm-nvim # -------> floating terminal
  #     nvim-notify # -----------> notify
  #     vim-dadbod-ui # ---------> navigation database gui
  #     oil-nvim # --------------> file explorer that lets you edit your filesystem like a normal Neovim buffer.
  #     plenary-nvim # ----------> All the lua functions I don't want to write twice.
  #     openscad-nvim # --------->
  #     coc-nvim # --------------> conquer of completion nvim
  #     coc-lua # ---------------> conquer of completion lua
  #     coc-rust-analyzer # -----> conquer of completion rust analyzer
  #     coc-tailwindcss # -------> conquer of completion of tailwindcss
  #     coc-fzf # ---------------> conquer of completion for fzf
  #     vim-nix # ---------------> writing Nix expressions
  #     comment-nvim # ----------> comment line
  #     conform-nvim # ----------> formating code
  #     markdown-nvim # ---------> beautify markdown
  #     markdown-preview-nvim # -> preview markdown file
  #     rest-nvim # -------------> asynchronous Neovim HTTP client
  #     rustaceanvim # ----------> Supercharge your Rust experience
  #     actions-preview-nvim # --> Better actions preview
  #     inc-rename-nvim # -------> LSP renaming with immediate visual feedback
  #     vim-flog # --------------> git graph
  #     fugitive # --------------> git commands
  #     lazygit-nvim # ----------> git interface
  #     bufferline-nvim # -------> tabs behavior
  #     nvim-colorizer-lua # ----> show color by code
  #     nvim-tree-lua # ---------> file explorer
  #     nvim-web-devicons # -----> provide Nerd Font icons
  #   ];
  # };
  #
  # home.packages = with pkgs; [
  #   luajit # ----------------> Just-In-Time compiler for Lua programming language
  #   stylua # ----------------> Opinionated Lua code formatter
  #   nixfmt-rfc-style # ------> Formatter for Nix code following RFC style
  #   prettierd # -------------> Prettier daemon for faster formatting
  #   isort # -----------------> Python utility to sort imports alphabetically
  #   black # -----------------> The uncompromising Python code formatter
  #   grc # -------------------> Generic text colouriser
  # ];
  #
  # home.sessionVariables = {
  #   EDITOR = "nvim";
  # };
# }
