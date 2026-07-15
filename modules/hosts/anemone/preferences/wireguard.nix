{ self, ... }: {
  flake.nixosModules.preferencesWireguardAnemone =
    { config, ... }:
    {
      preferences.wireguard.client.interfaces = {
        wg0 = {
          ip = "${self.lib.netwroks.wg0.hosts.anemone.ip}/24";
          serverPublicKey = self.lib.netwroks.wg0.hosts.coral.publicKey;
          allowedIPs = [ "10.100.0.0/24" ];
          serverPort = self.lib.netwroks.wg0.port;
          configFile = config.sops.templates."wg0.conf".path;
        };
      };
    };
}
