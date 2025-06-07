{ inputs, ... }:
let hostname = "plankton";
in {
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/users/nixos.nix
    ../../nixos/feat/disko-configuration.nix
    ./hardware-configuration.nix
  ];

  # To set
  disk.path = "/dev/sda";

  networking.hostName = "${hostname}";
}
