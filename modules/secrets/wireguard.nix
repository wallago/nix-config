{ lib, ... }:
let
  mkSecretKeys = lib.mapAttrs' (name: _: lib.nameValuePair "${name}-sk" { });
in
{
  flake.nixosModules.secretsWireguardServer =
    { config, ... }:
    {
      sops.secrets = mkSecretKeys config.preferences.wireguard.server.interfaces;
    };

  flake.nixosModules.secretsWireguardClient =
    { config, lib, ... }:
    let
      ifaces = config.preferences.wireguard.client.interfaces;
      wg-server = "vpn.wallago.xyz";
    in
    {
      sops.secrets = mkSecretKeys ifaces;

      sops.templates = lib.mapAttrs' (name: iface: {
        name = "${name}.conf";
        value.content = ''
          [Interface]
          PrivateKey = ${config.sops.placeholder."${name}-sk"}
          Address = ${iface.ip}

          [Peer]
          PublicKey = ${iface.serverPublicKey}
          AllowedIPs = ${lib.concatStringsSep ", " iface.allowedIPs}
          Endpoint = ${wg-server}:${toString iface.serverPort}
          PersistentKeepalive = 25
        '';
      }) ifaces;
    };
}
