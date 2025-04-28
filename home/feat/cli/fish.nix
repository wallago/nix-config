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
    shellAbbrs = {
      n = "nix";
      nd = "nix develop -c $SHELL";
      ns = "nix shell";
      nsn = "nix shell nixpkgs#";
      nb = "nix build";
      nbn = "nix build nixpkgs#";
      nf = "nix flake";
      npu = "nix-prefetch-url";

      nr = "nixos-rebuild --flake .";
      nrs = "nixos-rebuild --flake . switch";
      snr = "sudo nixos-rebuild --flake .";
      snrs = "sudo nixos-rebuild --flake . switch";
      hm = "home-manager --flake .";
      hms = "home-manager --flake . switch";

      gco = "git checkout";

      ls = lib.mkIf config.programs.eza.enable "eza";
      cat = lib.mkIf config.programs.bat.enable "bat";
      top = lib.mkIf config.programs.bottom.enable "bottom";
      grep = lib.mkIf config.programs.ripgrep.enable "ripgrep";
    };
    shellAliases = { clear = "printf '\\033[2J\\033[3J\\033[1;1H'"; };
  };

  home.packages = with pkgs.fishPlugins; [ fzf hydro ];
}
