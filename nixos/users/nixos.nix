{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
let
  username = "nixos";
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
    password = "nixos";
  };
}
