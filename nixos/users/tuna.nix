{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
let
  username = "tuna";
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
    ];
    hashedPasswordFile = config.sops.secrets.tuna-password.path;
  };

  sops.secrets.tuna-password = {
    sopsFile = ../common/secrets.yaml;
    neededForUsers = true;
  };
}
