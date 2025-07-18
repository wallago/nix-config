{ lib, config, pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      set fish_cursor_default     block      blink
      set fish_cursor_insert      line       blink
      set fish_cursor_replace_one underscore blink
      set fish_cursor_visual      block
    '';
    shellAliases = {
      # List directory contents
      l = lib.mkIf config.programs.eza.enable "eza -lah";
      ls = lib.mkIf config.programs.eza.enable "eza";
      tree = lib.mkIf config.programs.eza.enable "eza --tree --git-ignore";

      # Utilities
      cat = lib.mkIf config.programs.bat.enable "bat";
      top = lib.mkIf config.programs.bottom.enable "btm";
      man = lib.mkIf config.programs.bat.enable "batman";
      watch = lib.mkIf config.programs.bat.enable "batwatch";
      less = lib.mkIf config.programs.bat.enable "batpipe";
      grep = lib.mkIf config.programs.ripgrep.enable "rg";

      # Misc
      c = "printf '\\033[2J\\033[3J\\033[1;1H'";
      h = "history";
      cdp = "pwd | xclip -selection clipboard";
      ports = "netstat -tulamp";
      j = "just";
      mail-refresher = "mbsync -a -V";
      gpg-keys = "gpg --list-keys";

      # NixOS system management
      ns = "sudo nixos-rebuild switch --flake ";
      nb = "sudo nixos-rebuild build --flake ";
      ndb = "sudo nixos-rebuild dry-build --flake ";
      nfu = "nix flake update";
      npu = "nix-prefetch-url";
      ncg = "sudo nix-collect-garbage -d";
      ns-fix = "nix-store --verify --check-contents --repair";
      find-ns = "find /nix/store -name";
    };
  };

  home.packages = with pkgs; [ fishPlugins.fzf fishPlugins.hydro nettools ];
}
