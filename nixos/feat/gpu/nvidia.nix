{ config, ... }: {
  imports = [ ./default.nix ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  services.xserver.videoDrivers = [ "nvidia" ];
}
