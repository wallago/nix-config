{ inputs, ... }:
let hostname = "squid";
in {
  imports = [
    # (modulesPath + "/profiles/qemu-guest.nix")
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/feat/code
    ../../nixos/feat/desktop
    ../../nixos/feat/gpu/intel.nix
    ../../nixos/feat/tlp.nix
    ../../nixos/feat/peripherals.nix
    ../../nixos/feat/disko-configuration.nix
    ../../nixos/feat/bluetooth.nix
    ../../nixos/users/wallago.nix
    ./hardware-configuration.nix
  ];

  disk.path = "/dev/nvme0n1";

  networking = { hostName = "${hostname}"; };

  services.displayManager.gdm.banner = "go fuck your self";

  boot.binfmt.emulatedSystems =
    [ "aarch64-linux" "i686-linux" "riscv64-linux" ];

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    powerKey = "suspend";
    powerKeyLongPress = "poweroff";
  };
}
