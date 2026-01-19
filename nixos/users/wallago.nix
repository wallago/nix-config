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
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ifTheyExist [
      "wheel"
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
    shell = pkgs.fish;
    packages = [ pkgs.home-manager ];
    openssh.authorizedKeys.keys = lib.mapAttrsToList (
      _: yk: builtins.readFile yk.sshPub
    ) config.yubikey;
  };

  home-manager = {
    extraSpecialArgs.keymap = config.keymap;
    users.${username} = import ../../home/users/${username}/${config.networking.hostName}.nix;
  };

  users.groups.dialout = { };

  sops.secrets.wallago-password = {
    sopsFile = ../common/secrets.yaml;
    format = "yaml";
    neededForUsers = true;
  };
}
