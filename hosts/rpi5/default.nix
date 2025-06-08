{ inputs, ... }:
let hostname = "octopus";
in {
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/users/wallago.nix
    ../../nixos/feat/disko-configuration.nix
    ./hardware-configuration.nix
  ];

  disk.path = "/dev/sda";

  networking = { hostName = "${hostname}"; };
}
