{
  inputs,
  config,
  pkgs,
  outputs,
  ...
}:
let
  hostname = "shusui";
in
{
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disko-configuration.nix

    ../../nixos/common
    ../../nixos/users/yc

    ../../nixos/feat/desktop
  ];

  networking = {
    hostName = "${hostname}";
  };

  services.xserver.displayManager.gdm = {
    banner = "go fuck your self";
  };

  # NVIDIA GPU

  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [
    linuxPackages.nvidia_x11 # NVIDIA X11 driver for Linux

    rust-bin.nightly.latest.default
  ];

  # # Rust
  # environment.systemPackages = with pkgs; [
  # ];
}
