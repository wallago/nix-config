{ inputs, ... }:
let hostname = "enma";
in {
  imports = [
    ../../nixos/common
    ../../nixos/feat/code
    ../../nixos/feat/desktop
    ../../nixos/feat/gpu/intel.nix
    ../../nixos/feat/tlp.nix
    ../../nixos/users/yc
    ./disko-configuration.nix
    ./hardware-configuration.nix
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
  ];

  time.timeZone = "Europe/Paris";

  networking = { hostName = "${hostname}"; };

  services.xserver.displayManager.gdm = { banner = "go fuck your self"; };
}
