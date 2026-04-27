{ inputs, ... }:
let
  hostname = "plankton";
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/users/nixos.nix
    ../../nixos/feat/disko-configuration.nix
    ./hardware-configuration.nix
  ];

  disk.path = "/dev/sda";
  disk.swapSize = "512M";

  networking.hostName = "${hostname}";
}
