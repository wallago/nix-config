{ pkgs, config, inputs, ... }:
let
  username = "wallago";
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

in {
  imports = [
    # Includes the Home Manager module from the home-manager input in NixOS configuration
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
    # hashedPasswordFile = config.sops.secrets.wallago-password.path;
    password = "wallago";
    shell = pkgs.fish;
    packages = [ pkgs.home-manager ];
    openssh.authorizedKeys.keys =
      [ (builtins.readFile ../../feat/yubikey/ssh.pub) ];
  };

  home-manager.users.${username} =
    import ../../../home/users/${username}/${config.networking.hostName}.nix;

  # sops.secrets.wallago-password = {
  #   sopsFile = ../../common/secrets.yaml;
  #   format = "yaml";
  #   # Make this secret available early enough during system boot
  #   neededForUsers = true;
  # };
}
