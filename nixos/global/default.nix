{ config, ... }:
{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking.networkmanager.enable = true;

  system.stateVersion = "${config.system.nixos.release}";
}
