{ self, ... }: {
  flake.nixosModules.boot =
    { pkgs, lib, ... }:
    {
      imports = [ self.nixosModules.plymouth ];
      boot = {
        kernelPackages = lib.mkOverride 1100 pkgs.linuxPackages_latest;
        initrd = {
          verbose = lib.mkDefault true;
          systemd.enable = true;
        };
        kernelParams = [
          "systemd.show_status=auto"
        ];
        loader = {
          systemd-boot = {
            enable = lib.mkDefault true;
            configurationLimit = 10; # keep only the last 10 generations on /boot
          };
          efi.canTouchEfiVariables = lib.mkDefault true;
          timeout = 0;
        };
      };
    };

  flake.nixosModules.bootEmulatedSystems = {
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
