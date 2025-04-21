{ pkgs, lib, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = lib.mkDefault 4;
  };
}
