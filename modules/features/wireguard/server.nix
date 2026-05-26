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
          externalInterface = cfg.externalInterface;
          internalInterfaces = lib.attrNames cfg.interfaces;
        };
        wireguard.interfaces = lib.mapAttrs (_: iface: {
          ips = [ iface.ip ];
          listenPort = iface.listenPort;
          privateKeyFile = iface.privateKeyFile;
          peers = iface.peers;
        }) cfg.interfaces;
      };
    };
}
