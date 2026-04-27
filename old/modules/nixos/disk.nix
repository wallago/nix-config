{ lib, ... }:
let inherit (lib) mkOption types;
in {
  options.disk = {
    path = mkOption {
      type = types.str;
      example = "/dev/sda";
      description = ''
        Set path to the disk device.
      '';
    };
    swapSize = mkOption {
      type = types.str;
      default = "8196M";
      description = ''
        Set size of the swap part.
      '';
    };
  };
}
