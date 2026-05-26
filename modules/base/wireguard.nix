{
  flake.nixosModules.wireguardClientOptions =
    { lib, ... }:
    {
      options.preferences.wireguard.client = {
        interfaces = lib.mkOption {
          type = lib.types.attrsOf (
            lib.types.submodule {
              options = {
                configFile = lib.mkOption {
                  type = lib.types.path;
                  description = "Config file path";
                };
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

  flake.nixosModules.wireguardServerOptions =
    { lib, ... }:
    {
      options.preferences.wireguard.server = {
        externalInterface = lib.mkOption {
          type = lib.types.str;
          description = "NAT external interface (e.g. eth0)";
        };
        interfaces = lib.mkOption {
          type = lib.types.attrsOf (
            lib.types.submodule {
              options = {
                ip = lib.mkOption {
                  type = lib.types.str;
                  description = "Server IP with CIDR (e.g. 10.0.0.1/24)";
                };
                listenPort = lib.mkOption {
                  type = lib.types.port;
                  description = "UDP listen port";
                };
                privateKeyFile = lib.mkOption {
                  type = lib.types.str;
                  description = "Path to private key file";
                };
                peers = lib.mkOption {
                  type = lib.types.listOf (
                    lib.types.submodule {
                      options = {
                        publicKey = lib.mkOption { type = lib.types.str; };
                        allowedIPs = lib.mkOption { type = lib.types.listOf lib.types.str; };
                        endpoint = lib.mkOption {
                          type = lib.types.nullOr lib.types.str;
                          default = null;
                        };
                      };
                    }
                  );
                  default = [ ];
                  description = "List of peers for this interface";
                };
              };
            }
          );
          default = { };
          description = "WireGuard server interfaces";
        };
      };
    };
}
