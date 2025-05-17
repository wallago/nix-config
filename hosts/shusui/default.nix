{ inputs, ... }:
let hostname = "shusui";
in {
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/feat/code
    ../../nixos/feat/desktop
    ../../nixos/feat/gpu/nvidia.nix
    ../../nixos/users/wallago
    ./disko-configuration.nix
    ./hardware-configuration.nix
  ];

  time.timeZone = "Europe/Paris";

  networking = { hostName = "${hostname}"; };

  services.xserver.displayManager.gdm = { banner = "go fuck your self"; };

  boot.loader.grub.useOSProber = true;
}
