{ pkgs, config, inputs, lib, ... }:
let
  username = "nixos";
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

in {
  imports = [
    # Includes the Home Manager module from the home-manager input in NixOS configuration
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ifTheyExist [ "wheel" ];
    password = "nixos";
    shell = pkgs.fish;
    packages = [ pkgs.home-manager ];
    openssh.authorizedKeys.keys =
      builtins.map (key: builtins.readFile key.sshPub)
      (lib.attrValues config.yubikeys);
  };

  home-manager.users.${username} =
    import ../../home/users/${username}/${config.networking.hostName}.nix;
}
