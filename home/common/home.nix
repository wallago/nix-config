{ username, ... }:
{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "$HOME/Documents/NixConfig";
    };
    persistence = {
      "/persist/" = {
        directories = [
          "Documents/"
          "Downloads/"
          "Pictures/"
          "Videos/"
          ".local/bin/"
          ".local/share/nix/" # trusted settings and repl history
        ];
      };
    };
    stateVersion = "25.05";
  };
}
