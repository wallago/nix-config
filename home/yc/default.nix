{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    # Includes the Impermanence module from the impermanence input in NixOS configuration
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

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

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = "yc";
    homeDirectory = "/home/${config.home.username}";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "$HOME/Documents/NixConfig";
    };
    password = "yc";

    # Ensures that user data survives across system reboots by storing it in /persist
    persistence = {
      "/persist/${config.home.homeDirectory}" = {
        defaultDirectoryMethod = "symlink";
        directories = [
          # Common user data directories
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
          # Stores user scripts and executables
          ".local/bin"
          # Nix-related user data, including trusted settings and repl history
          ".local/share/nix"
        ];
        allowOther = true;
      };
    };
  };
}
