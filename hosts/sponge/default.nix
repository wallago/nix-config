{ inputs, ... }:
let hostname = "sponge";
in {
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/feat/code
    ../../nixos/feat/desktop
    ../../nixos/feat/gpu/nvidia.nix
    ../../nixos/feat/peripherals.nix
    ../../nixos/users/wallago
    ./disko-configuration.nix
    ./hardware-configuration.nix
  ];

  networking = { hostName = "${hostname}"; };

  services.xserver.displayManager.gdm = { banner = "go fuck your self"; };

  boot = {
    loader.grub.useOSProber = true;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" "riscv64-linux" ];
  };
}
