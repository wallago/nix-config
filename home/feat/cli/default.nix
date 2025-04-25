{ pkgs, ... }: {
  imports = [
    ./fish.nix
    ./bat.nix # -----> Better cat
    ./eza.nix # -----> Better ls
    ./ripgrep.nix # -> Better grep
    ./fzf.nix # -----> Fuzzy finder for fast searching in the terminal
    ./gpg.nix # -----> GnuPG
    ./ssh.nix # -----> -- WIP
    ./zellij # ------> Terminal multiplexer
  ];

  home.packages = with pkgs; [
    # Misc
    # lazygit # ------------> Simple terminal UI for git commands
    less # ---------------> More advanced file pager than 'more'
    trash-cli # ----------> Command line interface to the freedesktop.org trashcan.
    bc # -----------------> GNU software calculator
    bottom # -------------> Cross-platform graphical process/system monitor with a customizable interface
    fd # -----------------> Simple, fast and user-friendly alternative to find
    httpie # -------------> Command line HTTP client whose goal is to make CLI human-friendly
    jq # -----------------> Lightweight and flexible command-line JSON processor
    viddy # --------------> Modern watch command, time machine and pager etc

    # Nix
    nixd # ---------------> Feature-rich Nix language server interoperating with C++ nix
    alejandra # ----------> Uncompromising Nix Code Formatter
    nvd # ----------------> Nix/NixOS package version diff tool
    nix-diff # -----------> Explain why two Nix derivations differ
    nix-output-monitor # -> Processes output of Nix commands to show helpful and pretty information
    nh # -----------------> Yet another nix cli helper
  ];
}
