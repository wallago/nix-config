{
  flake.nixosModules.boot =
    { pkgs, lib, ... }:
    {
      boot = {
        kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
        # consoleLogLevel = 3;
        initrd = {
          verbose = true;
          systemd.enable = true;
        };
        kernelParams = [
          "systemd.show_status=auto"
        ];
        loader = {
          systemd-boot = {
            enable = true;
            configurationLimit = 10; # keep only the last 10 generations on /boot
          };
          efi.canTouchEfiVariables = true;
          timeout = 0;
        };
      };
    };
}
