{ self, ... }:
{
  flake.nixosModules.wireguardClient =
    {
      config,
      lib,
      hostName,
      ...
    }:
    let
      cfg = config.preferences.wireguard.client;
      hostModule = self.nixosModules."preferencesWireguard${self.lib.capitalize hostName}";
    in
    {
      imports = [
        self.nixosModules.wireguardClientOptions
        hostModule
      ];

      networking.wg-quick.interfaces = lib.mapAttrs (_: iface: {
        inherit (iface) configFile;
      }) cfg.interfaces;
    };

  flake.nixosModules.wireguardServer =
    {
      config,
      lib,
      hostName,
      ...
    }:
    let
      cfg = config.preferences.wireguard.server;
      hostModule = self.nixosModules."preferencesWireguard${self.lib.capitalize hostName}";
    in
    {
      imports = [
        self.nixosModules.wireguardServerOptions
        hostModule
      ];

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
