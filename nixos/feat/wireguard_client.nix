{ config, lib, ... }:
let
  inherit (lib) mapAttrs mapAttrs';
in
{
  sops.secrets = lib.mkMerge [
    {
      "wg-server-endpoint" = {
        sopsFile = ../common/secrets.yaml;
      };
    }
    (lib.mapAttrs' (name: _: {
      name = "${name}-sk";
      value = {
        sopsFile = ../../hosts/${config.networking.hostName}/secrets.yaml;
      };
    }) config.wg-client.interfaces)
  ];

  sops.templates = mapAttrs' (name: iface: {
    name = "${name}.conf";
    value = {
      content = ''
        [Interface]
        PrivateKey = ${config.sops.placeholder."${name}-sk"}
        Address = ${iface.ip}

        [Peer]
        PublicKey = ${iface.serverPublicKey}
        AllowedIPs = ${lib.concatStringsSep ", " iface.allowedIPs}
        Endpoint = ${config.sops.placeholder."wg-server-endpoint"}:${toString iface.serverPort}
        PersistentKeepalive = 25
      '';
    };
  }) config.wg-client.interfaces;

  networking.wg-quick.interfaces = mapAttrs (name: _: {
    configFile = config.sops.templates."${name}.conf".path;
  }) config.wg-client.interfaces;
}
