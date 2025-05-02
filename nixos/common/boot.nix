{ pkgs, lib, ... }: {
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    consoleLogLevel = lib.mkDefault 4;
  };
}
