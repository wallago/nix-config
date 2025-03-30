{
  inputs,
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
    (import ../common {
      inherit
        username
        lib
        pkgs
        config
        ;
    })
  ];

  users.users.${username} = {
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ];
    password = "${username}";
  };
}
