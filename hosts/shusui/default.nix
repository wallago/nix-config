{ inputs, ... }:
let hostname = "shusui";
in {
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko

    ./hardware-configuration.nix
    ./disko-configuration.nix

    ../../nixos/common
    ../../nixos/users/yc

    ../../nixos/feat/gpu/nvidia.nix
    ../../nixos/feat/desktop
    ../../nixos/feat/code
  ];

  time.timeZone = "Europe/Paris";

  networking = { hostName = "${hostname}"; };

  services.xserver.displayManager.gdm = { banner = "go fuck your self"; };
}
