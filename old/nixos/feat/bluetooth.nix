{ pkgs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez;
  };

  environment.systemPackages = with pkgs; [
    bluez-tools
    bluetuith
  ];
}
