{ self, ... }: {
  flake.nixosModules.preferencesWireguardSponge =
    { config, ... }:
    {
      preferences.wireguard.client.interfaces = {
        wg0 = {
          ip = "${self.lib.networks.wg0.hosts.sponge.ip}/24";
          serverPublicKey = self.lib.networks.wg0.hosts.coral.publicKey;
          allowedIPs = [ "10.100.0.0/24" ];
          serverPort = self.lib.networks.wg0.port;
          configFile = config.sops.templates."wg0.conf".path;
        };
        wg1 = {
          ip = "${self.lib.networks.wg1.hosts.sponge.ip}/24";
          serverPublicKey = self.lib.networks.wg1.hosts.coral.publicKey;
          allowedIPs = [ "10.200.0.0/24" ];
          serverPort = self.lib.networks.wg1.port;
          configFile = config.sops.templates."wg1.conf".path;
        };
      };
    };
}
