{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
let
  username = "wallago";
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [
    (import ./default.nix {
      inherit
        pkgs
        config
        inputs
        lib
        username
        ;
    })
  ];

  users.users.${username} = {
    extraGroups = ifTheyExist [
      "video"
      "audio"
      "disk"
      "docker"
      "git"
      "i2c"
      "network"
      "plugdev"
      "tss"
      "dialout"
    ];
    hashedPasswordFile = config.sops.secrets.wallago-password.path;
  };

  users.groups.dialout = { };

  sops.secrets.wallago-password = {
    sopsFile = ../common/secrets.yaml;
    neededForUsers = true;
  };
}
