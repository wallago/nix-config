{ config, lib, ... }:
{
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
