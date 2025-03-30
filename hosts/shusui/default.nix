{ inputs, ... }:
let
  hostname = "shusui";
in
{
  imports = [
    ./hardware-configuration.nix
    ./disko-configuration.nix
    (import ../../nixos/common {
      inherit
        hostname
        ;
    })
    ../../nixos/feat/desktop
  ];

  services.openssh.enable = true;

  services.xserver.displayManager.gdm = {
    banner = "go fuck your self";
  };
}
