{ username, ... }:
{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "$HOME/Documents/NixConfig";
      EDITOR = "nvim";
    };
    stateVersion = "25.05";
  };

}
