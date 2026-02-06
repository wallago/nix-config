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
    ];
    hashedPasswordFile = config.sops.secrets.tuna-password.path;
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

  sops.secrets.tuna-password = {
    sopsFile = ../common/secrets.yaml;
    neededForUsers = true;
  };
}
