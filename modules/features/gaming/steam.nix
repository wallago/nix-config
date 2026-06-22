{
  flake.nixosModules.steam =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      programs.steam = {
        enable = true;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin # Wine-based compatibility layer
        ];
        package = pkgs.steam.override {
          extraEnv = {
            MANGOHUD = true; # exported as MANGOHUD=1 inside Steam, inherited by every game
          };
          extraArgs = lib.optionalString (lib.elem "intel" config.services.xserver.videoDrivers) "-cef-disable-gpu";
        };
      };
      hardware.steam-hardware.enable = true; # Controller udev rules
      hardware.xpadneo.enable = true; # Driver required for Xbox controllers
    };
}
