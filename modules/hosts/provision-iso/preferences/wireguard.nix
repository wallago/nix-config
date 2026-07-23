{ self, ... }: {
  flake.nixosModules.preferencesWireguardProvisionIso =
    { config, ... }:
    let
      inherit (self.lib.wireguard.wg1) hosts port;
    in
    {
      preferences.wireguard.client.interfaces = {
        wg1 = {
          ip = "${hosts.provision-iso.ip}/24";
          serverPublicKey = hosts.coral.publicKey;
          allowedIPs = [ "10.200.0.0/24" ];
          serverPort = port;
          configFile = config.sops.templates."wg1.conf".path;
        };
      };
    };
}
