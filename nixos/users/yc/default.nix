{
  pkgs,
  config,
  inputs,
  ...
}:
let
  username = "yc";
in
{
  imports = [
    # Includes the Home Manager module from the home-manager input in NixOS configuration
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ];
    password = "${username}";
    shell = pkgs.fish;
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.${username} =
    import ../../../home/users/${username}/${config.networking.hostName}.nix;
}
