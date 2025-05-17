{ pkgs, ... }: {
  imports = [
    ./fish.nix
    ./bat.nix
    ./eza.nix
    ./jujutsu.nix
    ./ripgrep.nix
    ./fzf.nix
    ./gpg.nix
    ./ssh.nix
    ./zellij
    ./fd.nix
    ./git.nix
    ./bash.nix
    ./bottom.nix
    ./direnv.nix
    ./nix_index.nix
    ./jq.nix
  ];

  home.packages = with pkgs; [
    comma
    bc
    httpie
    ncdu
    timer
    viddy
    nix-output-monitor
    nixd
  ];
}
