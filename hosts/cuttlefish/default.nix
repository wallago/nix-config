{ inputs, config, ... }:
let
  hostname = "cuttlefish";
  wg-pk = config.sops.secrets."wg-client-pk".path;
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/users/tuna.nix
    ../../nixos/feat/disko-configuration.nix
    ../../nixos/feat/wireguard_client.nix
    ./hardware-configuration.nix
  ];

  disk.path = "/dev/nvme0n1";

  networking.hostName = "${hostname}";

  wg-client = {
    privateKeyFile = wg-pk;
    ip = "10.100.0.4/24";
  };

  sops.secrets."wg-client-pk" = {
    sopsFile = ./secrets.yaml;
    format = "yaml";
  };
}
