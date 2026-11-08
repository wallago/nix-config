{ self, ... }:
{
  flake.nixosModules.intel =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.graphics
      ];

      # xf86-video-intel can't drive Gen12+ (Alder Lake): use modesetting
      services.xserver.videoDrivers = [ "modesetting" ];

      hardware.graphics = {

        extraPackages = with pkgs; [
          intel-media-driver
          vpl-gpu-rt
        ];
        extraPackages32 = with pkgs; [
          intel-media-driver
          vpl-gpu-rt
        ];
      };

      environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
    };
}
