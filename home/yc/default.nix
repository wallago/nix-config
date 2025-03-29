{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  username = "yc";
in
{
  imports = [
    # Includes the Home Manager module from the home-manager input in NixOS configuration
    inputs.home-manager.nixosModules.home-manager
    ../common
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
