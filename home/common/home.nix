{ username, config }:
{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "$HOME/Documents/NixConfig";
      EDITOR = "nvim";
    };
    stateVersion = "${config.system.nixos.release}";
  };

}
