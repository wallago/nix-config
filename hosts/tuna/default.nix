{ inputs, ... }:
let hostname = "tuna";
in {
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    inputs.raspberry-pi-nix.nixosModules.raspberry-pi

    ./hardware-configuration.nix
    ./disko-configuration.nix

    ../../nixos/common
    ../../nixos/users/yc

    # ../../nixos/feat/desktop
    # ../../nixos/feat/code
  ];

  time.timeZone = "Europe/Paris";

  networking = { hostName = "${hostname}"; };

  services.xserver.displayManager.gdm = { banner = "go fuck your self"; };

  # --- RPI --- #
  raspberry-pi-nix.board = "bcm2712";
  boot.loader.grub.enable = false;
}
