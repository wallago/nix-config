{
  flake.nixosModules.plymouth =
    { pkgs, ... }:
    {
      boot = {
        plymouth = {
          enable = true;
          theme = "catppuccin-mocha";
          themePackages = [
            (pkgs.catppuccin-plymouth.override { variant = "mocha"; })
          ];
        };
        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "udev.log_priority=3"
        ];
      };
    };
}
