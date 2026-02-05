{ inputs, config, ... }:
let
  hostname = "cuttlefish";
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/users/tuna.nix
    ../../nixos/feat/disko-configuration.nix
    ../../nixos/feat/wireguard_client.nix
    ./services
    ./hardware-configuration.nix
  ];

  disk.path = "/dev/nvme0n1";

  networking.hostName = "${hostname}";

  wg-client = {
    ip = "10.100.0.4/24";
  };
}
