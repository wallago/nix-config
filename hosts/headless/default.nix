{ inputs, config, ... }:
let
  hostname = "headless";
in
{
  imports = [
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/feat/gpu/intel.nix
    ../../nixos/feat/peripherals.nix
    ../../nixos/feat/disko-configuration.nix
    ../../nixos/feat/docker.nix
    ../../nixos/feat/wireguard_client.nix
    ../../nixos/users/work.nix
    ./hardware-configuration.nix
  ];

  disk.path = "/dev/nvme0n1";

  networking.hostName = "${hostname}";

  services.displayManager.gdm.banner = "go here to work";

  boot = {
    loader.grub.useOSProber = true;
  };

  wg-client.interfaces = {
    wg1 = {
      # TODO
      # Change IP accordingly to Wireguard server availability IPs
      ip = "10.200.0.5/24";
      serverPublicKey = "VwQJyFAj9053C6dT6zB/JZ9kBZ/wma1b+xfpB+eCRXs=";
      allowedIPs = [ "10.200.0.0/24" ];
      serverPort = 51840;
    };
  };

  ssh.users.wallago.allowedKeys = [
    ../../ssh_keys/ssh_squid_wallago_ed25519_key.pub
    ../../ssh_keys/ssh_sponge_wallago_ed25519_key.pub
    ../../ssh_keys/ssh_work_julia_ed25519_key.pub
  ];
}
