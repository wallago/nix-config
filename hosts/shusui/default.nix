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

  ];

  services.openssh.enable = true;
}
