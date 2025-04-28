{ username, config, ... }: {
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = { FLAKE = "$HOME/Documents/NixConfig"; };
    persistence = {
      "/persist/${config.home.homeDirectory}" = {
        defaultDirectoryMethod = "symlink";
        directories = [
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
          ".local/bin"
          ".local/share/nix" # trusted settings and repl history
        ];
        allowOther = true;
      };
    };
    stateVersion = "25.05";
  };

}
