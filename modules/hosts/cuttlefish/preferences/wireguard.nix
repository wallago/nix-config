{ self, ... }: {
  flake.nixosModules.preferencesWireguardCuttlefish =
    { config, ... }:
    let
      inherit (self.lib.wireguard.wg0) hosts port;
    in
    {
      preferences.wireguard.client.interfaces = {
        wg0 = {
          ip = "${hosts.cuttlefish.ip}/24";
          serverPublicKey = hosts.coral.publicKey;
          allowedIPs = [ "10.100.0.0/24" ];
          serverPort = port;
          configFile = config.sops.templates."wg0.conf".path;
        };
      };
    };
}
