{
  flake.nixosModules.preferencesWireguardProvisionIso =
    { config, ... }:
    {
      preferences.wireguard.client.interfaces = {
        wg1 = {
          ip = "10.200.0.254/24";
          serverPublicKey = "VwQJyFAj9053C6dT6zB/JZ9kBZ/wma1b+xfpB+eCRXs=";
          allowedIPs = [ "10.200.0.0/24" ];
          serverPort = 51840;
          configFile = config.sops.templates."wg1.conf".path;
        };
      };
    };
}
