{ self, ... }: {
  flake.nixosModules.boot =
    { pkgs, lib, ... }:
    {
      imports = [ self.nixosModules.plymouth ];
      boot = {
        kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
        initrd = {
          verbose = lib.mkDefault true;
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
