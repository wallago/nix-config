{
  lib,
  pkgs,
  config,
  inputs,
  outputs,
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

  home-manager.users.${username} =
    import ../../../home/users/${username}/${config.networking.hostName}.nix
      { inherit lib pkgs config; };
}
