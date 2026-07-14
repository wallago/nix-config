{ self, ... }:
{
  flake.nixosModules.nvidia =
    { config, ... }:
    {
      imports = [
        self.nixosModules.graphics
      ];

      services.xserver.videoDrivers = [ "nvidia" ];

      boot.initrd.kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];

      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = true;
        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
        videoAcceleration = true;
      };
    };
}
