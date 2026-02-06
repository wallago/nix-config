{ inputs, ... }:
let
  hostname = "coral";
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/feat/gpu/intel.nix
    ../../nixos/feat/docker.nix
    ../../nixos/users/wallago.nix
    ../../nixos/feat/disko-configuration.nix
    ./hardware-configuration.nix
    ./services
  ];

  disk.path = "/dev/nvme0n1";

  networking.hostName = "${hostname}";
}
