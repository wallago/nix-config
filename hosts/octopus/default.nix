{ inputs, ... }:
let hostname = "octopus";
in {
  imports = [
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/users/wallago.nix
    ../../nixos/feat/disko-configuration.nix
    ./hardware-configuration.nix
  ];

  disk.path = "/dev/sda";

  networking.hostName = "${hostname}";
}
