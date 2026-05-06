{ self, ... }:
{
  flake.nixosModules.intel =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.graphics
      ];

      services.xserver.videoDrivers = [ "intel" ];

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
