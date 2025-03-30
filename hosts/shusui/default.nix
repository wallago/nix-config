{ inputs, ... }:
let
  hsotname = "shusui";
in
{
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    # Includes the Home Manager module from the home-manager input in NixOS configuration
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ./disko-configuration.nix
  ];

  services.openssh.enable = true;
}
