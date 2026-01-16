{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.wg-client = {
    ip = mkOption {
      type = types.str;
      default = "10.100.0.2/24";
      description = ''
        Set IP.
      '';
    };
  };
}
