{ lib, ... }: {
  boot.loader.grub = {
    enable = lib.mkDefault true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
}
