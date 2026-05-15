{
  flake.nixosModules.wireguardClientOptions =
    { lib, ... }:
    {
      options.preferences.wireguard.client = {
        interfaces = lib.mkOption {
          type = lib.types.attrsOf (
            lib.types.submodule {
              options = {
                serverPublicKey = lib.mkOption {
                  type = lib.types.str;
                  description = "Server public key";
                };
                serverPort = lib.mkOption {
                  type = lib.types.port;
                  description = "Server port";
                };
                ip = lib.mkOption {
                  type = lib.types.str;
                  description = "Client IP address with CIDR";
                };
                allowedIPs = lib.mkOption {
                  type = lib.types.listOf lib.types.str;
                  description = "Allowed IPs for this peer";
                };
              };
            }
          );
          default = { };
          description = "WireGuard client interfaces";
        };
      };
    };
}
