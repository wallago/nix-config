{ self, ... }: {
  flake.nixosModules.preferencesWireguardSponge =
    { config, ... }:
    let
      inherit (self.lib.wireguard) wg1 wg0;
    in
    {
      preferences.wireguard.client.interfaces = {
        wg0 = {
          ip = "${wg0.hosts.sponge.ip}/24";
          serverPublicKey = wg0.hosts.coral.publicKey;
          allowedIPs = [ "10.100.0.0/24" ];
          serverPort = wg0.port;
          configFile = config.sops.templates."wg0.conf".path;
        };
        wg1 = {
          ip = "${wg1.hosts.sponge.ip}/24";
          serverPublicKey = wg1.hosts.coral.publicKey;
          allowedIPs = [ "10.200.0.0/24" ];
          serverPort = wg1.port;
          configFile = config.sops.templates."wg1.conf".path;
        };
      };
    };
}
