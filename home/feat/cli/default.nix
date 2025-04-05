{ pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./bat.nix # -> Cat(1) clone with syntax highlighting and Git integration
    ./fzf.nix # -> Command-line fuzzy finder for efficient searching and filtering
  ];

  home.packages = with pkgs; [
    # Misc
    lazygit # ------------> Simple terminal UI for git commands
    eza # ----------------> A modern replacement for ls
    ripgrep # ------------> Utility that combines the usability of The Silver Searcher with the raw speed of grep
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
