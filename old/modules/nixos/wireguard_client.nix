{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.wg-client = {
    interfaces = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            serverPublicKey = mkOption {
              type = types.str;
              description = "Server public key";
            };
            serverPort = mkOption {
              type = types.port;
              description = "Server port";
            };
            ip = mkOption {
              type = types.str;
              description = "Client IP address with CIDR";
            };
            allowedIPs = mkOption {
              type = types.listOf types.str;
              description = "Allowed IPs for this peer";
            };
          };
        }
      );
      default = { };
      description = "WireGuard client interfaces";
    };
  };
}
