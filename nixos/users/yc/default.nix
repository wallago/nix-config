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
  imports = [
    ../common
  ];

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
    import ../../../home/users/${username}/${config.networking.hostName}.nix;
}
