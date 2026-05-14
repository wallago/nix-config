{
  flake.nixosModules.steam =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin # Wine-based compatibility layer
        ];
      };
      hardware.steam-hardware.enable = true; # Controller udev rules
      hardware.xpadneo.enable = true; # Driver required for Xbox controllers
    };
}
