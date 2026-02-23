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

  wg-client.interfaces.wg0 = {
    ip = "10.100.0.4/24";
    allowedIPs = [ "10.100.0.0/24" ];
    serverPublicKey = "FoiHQJLNM4aCmuvf2g2Mb6wqe8kU00AqWd7hGvNLZzY=";
    serverPort = 51820;
  };

  ssh.users.tuna.allowedKeys = [
    ../squid/ssh_wallago_ed25519_key.pub
    ../sponge/ssh_wallago_ed25519_key.pub
  ];
}
