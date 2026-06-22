{
  flake.nixosModules.secretsCuttlefish =
    { config, lib, ... }:
    let
      ifaces = config.preferences.wireguard.client.interfaces;
      wg-server = "vpn.wallago.xyz";
    in
    {
      sops = {
        secrets = lib.mkMerge [
          {
            wallago-password.neededForUsers = true;
          }
          (lib.mapAttrs' (name: _: {
            name = "${name}-sk";
            value = { };
          }) ifaces)
        ];
        templates = lib.mapAttrs' (name: iface: {
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
    };
}
