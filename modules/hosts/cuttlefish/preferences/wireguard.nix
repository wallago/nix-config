{
  flake.nixosModules.preferencesWireguardCuttlefish =
    { config, ... }:
    {
      preferences.wireguard.client.interfaces = {
        wg0 = {
          ip = "10.100.0.4/24";
          serverPublicKey = "FoiHQJLNM4aCmuvf2g2Mb6wqe8kU00AqWd7hGvNLZzY=";
          allowedIPs = [ "10.100.0.0/24" ];
          serverPort = 51820;
          configFile = config.sops.templates."wg0.conf".path;
        };
      };
    };
}
