{ inputs, ... }: {
  flake.nixosModules.hardwareAnemone =
    { pkgs, ... }:
    {
      boot.loader = {
        systemd-boot.enable = false;
        efi.canTouchEfiVariables = false;
        raspberry-pi.bootloader = "kernel";
      };

      hardware.deviceTree.enable = true;

      boot.kernelPackages =
        inputs.nixos-raspberrypi.packages.${pkgs.stdenv.hostPlatform.system}.linuxPackages_rpi5.extend
          (
            _: prev: {
              kernel =
                let
                  withTarget =
                    k:
                    k
                    // {
                      target = "Image";
                      override = args: withTarget (k.override args);
                    };
                in
                withTarget prev.kernel;
            }
          );

      nixpkgs.hostPlatform = "aarch64-linux";
    };
}
