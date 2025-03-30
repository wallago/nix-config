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
  };

  home-manager.users.${username} = {
    imports = [
      (import ../../home/common {
        inherit
          lib
          pkgs
          config
          username
          ;
      })
      ../../home/feat/desktop
    ];
  };
}
