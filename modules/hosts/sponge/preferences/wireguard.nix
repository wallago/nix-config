{
  flake.nixosModules.preferencesWireguardSponge = {
    preferences.wireguard.client.interfaces = {
      wg0 = {
        ip = "10.100.0.3/24";
        serverPublicKey = "FoiHQJLNM4aCmuvf2g2Mb6wqe8kU00AqWd7hGvNLZzY=";
        allowedIPs = [ "10.100.0.0/24" ];
        serverPort = 51820;
      };
      wg1 = {
        ip = "10.200.0.3/24";
        serverPublicKey = "VwQJyFAj9053C6dT6zB/JZ9kBZ/wma1b+xfpB+eCRXs=";
        allowedIPs = [ "10.200.0.0/24" ];
        serverPort = 51840;
      };
    };
  };
}
