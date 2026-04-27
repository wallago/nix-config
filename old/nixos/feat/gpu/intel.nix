{ pkgs, ... }: {
  imports = [ ./default.nix ];

  services.xserver.videoDrivers = [ "intel" ];

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
      vulkan-loader
      intel-ocl
    ];
    extraPackages32 = with pkgs; [ vulkan-loader intel-vaapi-driver ];
  };

  boot.kernelParams = [ "i915.enable_fbc=1" "i915.fastboot=1" ];
  boot.initrd.kernelModules = [ "i915" ];
}
