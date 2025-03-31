{
  lib,
  pkgs,
  config,
  ...
}:
let
  username = "yc";
in
{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ];
    password = "${username}";
    shell = pkgs.fish;
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.${username} = import ../../../home/${username}/${config.networking.hostName}.nix;
}
