{ inputs, modulesPath, ... }:
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
    ../../nixos/users/wallago.nix
    ./disko-configuration.nix
    ./hardware-configuration.nix
  ];

  networking = { hostName = "${hostname}"; };

  services.xserver.displayManager.gdm = { banner = "go fuck your self"; };

  boot.binfmt.emulatedSystems =
    [ "aarch64-linux" "i686-linux" "riscv64-linux" ];

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    powerKey = "suspend";
    powerKeyLongPress = "poweroff";
  };
}
