{
  username,
  lib,
  pkgs,
  config,
  ...
}:
{
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        # Enables the new Nix CLI commands
        "nix-command"
        # Enables Nix flakes
        "flakes"
        # The hash is based on the output rather than the inputs.
        "ca-derivations"
      ];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  systemd.user.startServices = "sd-switch";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "$HOME/Documents/NixConfig";
    };
    stateVersion = "${config.system.nixos.release}";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraConfig = ''
      ${builtins.readFile ./config.vim}
      set shadafile=~/.local/share/nvim/custom.shada
    '';
    extraLuaConfig = ''
      ${builtins.readFile ./plugins/bufferline.lua}
      ${builtins.readFile ./plugins/colorizer.lua}
      ${builtins.readFile ./plugins/conform.lua}
      ${builtins.readFile ./plugins/gruvbox.lua}
      ${builtins.readFile ./plugins/inc-rename.lua}
      ${builtins.readFile ./plugins/neogit.lua}
      ${builtins.readFile ./plugins/notify.lua}
      ${builtins.readFile ./plugins/nvim-tree.lua}
      ${builtins.readFile ./plugins/rest.lua}
      ${builtins.readFile ./plugins/toggleterm.lua}
      ${builtins.readFile ./plugins/tokyonight.lua}
      ${builtins.readFile ./keybindings.lua}
      ${builtins.readFile ./config.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      # ========================
      # misc
      # ========================
      toggleterm-nvim # floating terminal
      telescope-nvim # fuzzy finder over lists
      nvim-notify # notify
      vim-dadbod-ui # navigation database gui
      oil-nvim # file explorer that lets you edit your filesystem like a normal Neovim buffer.
      plenary-nvim # All the lua functions I don't want to write twice.
      openscad-nvim
      # ========================
      # code
      # ========================
      coc-nvim # conquer of completion nvim
      coc-lua # conquer of completion lua
      coc-rust-analyzer # conquer of completion rust analyzer
      coc-tailwindcss # conquer of completion of tailwindcss
      coc-fzf # conquer of completion for fzf
      vim-nix # writing Nix expressions
      comment-nvim # comment line
      conform-nvim # formating code
      markdown-nvim # beautify markdown
      markdown-preview-nvim # preview markdown file
      nvim-lspconfig # Language Server Protocol
      rest-nvim # asynchronous Neovim HTTP client
      rustaceanvim # Supercharge your Rust experience
      actions-preview-nvim # Better actions preview

      inc-rename-nvim # LSP renaming with immediate visual feedback

      # ========================
      # git
      # ========================
      vim-flog # git graph
      fugitive # git commands
      neogit # git interface
      lazygit-nvim # git interface
      # ========================
      # clean gui
      # ========================
      bufferline-nvim # tabs behavior
      which-key-nvim # displays available keybindings
      gruvbox-nvim # colorsheme
      tokyonight-nvim # colorsheme
      nvim-colorizer-lua # show color by code
      nvim-tree-lua # file explorer
      nvim-web-devicons # provide Nerd Font icons
      {
        # https://github.com/nvim-treesitter/nvim-treesitter
        plugin = nvim-treesitter.withPlugins (
          plugins: with plugins; [
            tree-sitter-bash
            tree-sitter-c
            tree-sitter-cmake
            tree-sitter-css
            tree-sitter-gitignore
            tree-sitter-html
            tree-sitter-javascript
            tree-sitter-json
            tree-sitter-latex
            tree-sitter-lua
            tree-sitter-markdown
            tree-sitter-markdown_inline
            tree-sitter-mermaid
            tree-sitter-nix
            tree-sitter-proto
            tree-sitter-python
            tree-sitter-rust
            tree-sitter-sql
            tree-sitter-toml
            tree-sitter-typescript
            tree-sitter-vim
            tree-sitter-vimdoc
            tree-sitter-yaml
            tree-sitter-http
          ]
        );
        type = "lua";
      }
    ];
  };

  home.packages = with pkgs; [
    luajit # Just-In-Time compiler for Lua programming language
    stylua # Opinionated Lua code formatter
    nixfmt-rfc-style # Formatter for Nix code following RFC style
    prettierd # Prettier daemon for faster formatting
    isort # Python utility to sort imports alphabetically
    black # The uncompromising Python code formatter
    nodePackages.prettier # Multi-language code formatter
  ];
}
