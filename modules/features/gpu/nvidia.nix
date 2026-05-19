{ self, ... }:
{
  flake.nixosModules.nvidia = {
    imports = [
      self.nixosModules.graphics
    ];

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      # package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      powerManagement.enable = true;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;
      open = false;
    };
  };
}
