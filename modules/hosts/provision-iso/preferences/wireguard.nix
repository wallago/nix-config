{ self, ... }: {
  flake.nixosModules.preferencesWireguardProvisionIso =
    { config, ... }:
    {
      preferences.wireguard.client.interfaces = {
        wg1 = {
          ip = "${self.lib.networks.wg1.hosts.provision-iso.ip}/24";
          serverPublicKey = self.lib.networks.wg1.hosts.coral.publicKey;
          allowedIPs = [ "10.200.0.0/24" ];
          serverPort = self.lib.networks.wg1.port;
          configFile = config.sops.templates."wg1.conf".path;
        };
      };
    };
}
