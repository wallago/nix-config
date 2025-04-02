{
  inputs,
  config,
  pkgs,
  ...
}:
let
  hostname = "shusui";
in
{
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    # Includes the Home Manager module from the home-manager input in NixOS configuration
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ./disko-configuration.nix

    (import ../../nixos/common { inherit hostname config pkgs; })
    ../../nixos/users/yc

    ../../nixos/feat/desktop
  ];

  services.xserver.displayManager.gdm = {
    banner = "go fuck your self";
  };
}
