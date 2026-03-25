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
      "audio" # access to sound cards (/dev/snd/*)
      "video" # access to GPU and capture devices (/dev/dri/*, /dev/video*).
      "docker" # run Docker without sudo
    ];
    hashedPasswordFile = config.sops.secrets.tuna-password.path;
  };

  sops.secrets.tuna-password = {
    sopsFile = ../common/secrets.yaml;
    neededForUsers = true;
  };
}
