{ inputs, ... }:
let hostname = "octopus";
in {
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/users/wallago.nix
    ./disko-configuration.nix
    ./hardware-configuration.nix
  ];

  networking = { hostName = "${hostname}"; };

  services.xserver.displayManager.gdm = { banner = "go fuck your self"; };
}
