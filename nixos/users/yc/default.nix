{ pkgs, config, inputs, ... }:
let
  username = "yc";
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
      "docker"
      "git"
      "i2c"
      "network"
      "plugdev"
    ];
    # hashedPasswordFile = config.sops.secrets.yc-password.path;
    password = "yc";
    shell = pkgs.fish;
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.${username} =
    import ../../../home/users/${username}/${config.networking.hostName}.nix;

  # sops.secrets.yc-password = {
  #   sopsFile = ../../common/secrets.yaml;
  #   format = "yaml";
  #   # Make this secret available early enough during system boot
  #   neededForUsers = true;
  # };

  security.pam.services.hyprlock = {
    text = ''
      auth include login
      account include login
    '';
  };
}
