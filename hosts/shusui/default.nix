{ inputs, ... }:
{
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disko-configuration.nix
    ../common
  ];
}
