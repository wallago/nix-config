{
  flake.nixosModules.boot =
    { pkgs, lib, ... }:
    {
      boot = {
        kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
          "systemd.show_status=auto"
        ];
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        loader.timeout = 0;
      };
    };
}
