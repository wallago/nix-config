{ config, pkgs, ... }:
{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.dbus.enable = true;

  networking.networkmanager.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "exa -l";
      la = "exa -a";
      ls = "exa -la";

      top = "htop";

      rm = "trash-put";
      rm-list = "trash-list";
      rm-undo = "trash-restore";
      rm-all-for-real = "trash-empty";
      rm-for-real = "trash-rm";

      nix-list = "nixos-rebuild list-generations";
      nix-rebuild = "sudo nixos-rebuild switch --flake ";
      nix-clean-all = "sudo nix-collect-garbage -d";

      gg = "lazygit";
      gg-reset-last-commit = "git commit --amend";
      gg-stash = "git stash";
      gg-stash-back = "git stash pop";
      gg-tag = "git tag";

      tx-new = "tmux new -d -n window -c ~/ -s";
      tx-kill = "tmux kill-session -t";
      tx-kill-all = "tmux kill-server";
      tx-list = "tmux list-sessions";
      tx-switch = "tmux switch-client -t";
      tx-split-h = "tmux split-window -h";
      tx-split-v = "tmux split-window -v";
      tx-rename = "tmux rename-session";

      tar-out = "tar -xvzf";
      tar-in = "tar -czvf";

      clippy-full = "cargo clippy --all-targets --all-features -- -D warnings -W clippy::all -W clippy::pedantic -W clippy::nursery -W clippy::perf -W clippy::complexity -W clippy::suspicious -W clippy::style -W clippy::correctness";
      clippy-all = "cargo clippy --all-targets --all-features -- -D warnings -W clippy::all";
      clippy-cargo = "cargo clippy --all-targets --all-features -- -D warnings -W clippy::cargo";
      clippy-nursery = "cargo clippy --all-targets --all-features -- -D warnings -W clippy::nursery";
      clippy-pedantic = "cargo clippy --all-targets --all-features -- -D warnings -W clippy::pedantic";
      clippy-perf = "cargo clippy --all-targets --all-features -- -D warnings -W clippy::perf";
      clippy-restriction = "cargo clippy --all-targets --all-features -- -D warnings -W clippy::restriction";
      clippy-complexity = "cargo clippy --all-targets --all-features -- -D warnings -W clippy::complexity";
      clippy-style = "cargo clippy --all-targets --all-features -- -D warnings -W clippy::style";
      clippy-suspicious = "cargo clippy --all-targets --all-features -- -D warnings -W clippy::suspicious";
      clippy-correctness = "cargo clippy --all-targets --all-features -- -D warnings -W clippy::correctness";

      cargo-check-udeps = "rustup run nightly cargo udeps --all-targets  --all-features";
      cargo-tree-search = "cargo tree -i";

      cargo-run-nix = "nix-shell --run \"cargo run\"";
      cargo-build-nix = "nix-shell --run \"cargo build --release\"";

      gbk = "/etc/misc/generate_boot_key.fish";
    };
    interactiveShellInit = ''
      # Set vi mode
      fish_vi_key_bindings

      # Set theme if not already set
      if not set -q THEME
          set -xU THEME gruvbox-light
      end

      # Initialize fzf
      fzf --fish | source

      # Set some useful environment variables
      set -gx VISUAL $EDITOR
      set -gx PAGER less

      # Configure less
      set -gx LESS '-R --use-color -Dd+r$Du+b'

      # Configure man pages
      set -gx MANPAGER 'less -R --use-color -Dd+r -Du+b'

      # Enable syntax highlighting for man pages using bat
      if type -q bat
        set -gx MANROFFOPT "-c"
        set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
      end

      # Greeting message
      function fish_greeting
        echo "󱐋 This is your way 󱐋"
        commandline -f repaint
      end

      # Load tide configuration
      if type -q tide
        tide configure \
          --auto \
          --style=Rainbow \
          --prompt_colors='True color' \
          --show_time=No \
          --rainbow_prompt_separators=Angled \
          --powerline_prompt_heads=Sharp \
          --powerline_prompt_tails=Flat \
          --powerline_prompt_style='Two lines, character' \
          --powerline_prompt_style='One line' \
          # --prompt_connection=Solid \
          # --powerline_right_prompt_frame=No \
          # --prompt_connection_andor_frame_color=Dark \
          --prompt_spacing=Compact \
          --icons='Many icons' \
          --transient=No
      end
    '';
  };

  environment.systemPackages = with pkgs; [
    fish # The friendly interactive shell
    fishPlugins.done # Automatically receive notifications when long processes finish
    fishPlugins.fifc # Fzf powers on top of fish completion engine and allows customizable completion rules
    fishPlugins.fzf # Ef-fish-ient fish keybindings for fzf
    fishPlugins.grc # Generic Colouriser to add color to command output
    fishPlugins.z # Directory jumping tool that learns your habits
    fishPlugins.forgit # Utility tool powered by fzf for using git interactively
    fishPlugins.tide # A modern, powerful and flexible prompt for fish
    fishPlugins.pisces # Automagically adds matching pairs (parentheses, quotes, etc.)
    fishPlugins.sponge # Keeps your fish shell history clean from typos, incorrectly used commands and everything you don"t…
    fishPlugins.fish-bd # Fish plugin to quickly go back to a parent directory up in your current working directory tree
    fishPlugins.autopair # Auto-complete matching pairs in the Fish command line
    fishPlugins.foreign-env # Foreign environment interface for Fish shell
    fishPlugins.plugin-sudope # Fish plugin to quickly put "sudo" in your command
    fishPlugins.humantime-fish # Turn milliseconds into a human-readable string in Fish
    fishPlugins.colored-man-pages # Adds color to man pages for improved readability
    fishPlugins.fish-you-should-use # Fish plugin that reminds you to use your aliases
    fishPlugins.plugin-git # Git plugin for fish (similar to oh-my-zsh git)
  ];

  environment.shells = with pkgs; [ fish ];

  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   viAlias = true;
  #   vimAlias = true;
  # };

  system.stateVersion = "${config.system.nixos.release}";
}
