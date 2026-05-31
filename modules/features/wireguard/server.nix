{ self, ... }:
{
  flake.nixosModules.wireguardServer =
    { config, lib, ... }:
    let
      cfg = config.preferences.wireguard.server;
    in
    {
      imports = [ self.nixosModules.wireguardServerOptions ];

      networking = {
        firewall.allowedUDPPorts = lib.mapAttrsToList (_: iface: iface.listenPort) cfg.interfaces;
        nat = {
          enable = true;
          inherit (cfg) externalInterface;
          internalInterfaces = lib.attrNames cfg.interfaces;
        };
        wireguard.interfaces = lib.mapAttrs (_: iface: {
          ips = [ iface.ip ];
          inherit (iface) listenPort;
          inherit (iface) privateKeyFile;
          inherit (iface) peers;
        }) cfg.interfaces;
      };
    };
}
