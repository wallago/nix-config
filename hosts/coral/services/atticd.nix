{ config, ... }:
let
  key = config.sops.secrets.atticd-key.path;
in
{
  services.atticd = {
    enable = true;
    environmentFile = key;
    settings = {
      listen = "[::]:5504";
      api-endpoint = "https://cache.wallago.xyz/";
      allowed-hosts = [ "cache.wallago.xyz" ];
      soft-delete-caches = false;
      require-proof-of-possession = true;
      database.url = "postgresql:///atticd?host=/run/postgresql&user=atticd";
      chunking = {
        nar-size-threshold = 65536;
        min-size = 16384;
        avg-size = 65536;
        max-size = 262144;
      };
      compression.type = "zstd";
      garbage-collection = {
        interval = "12 hours";
        default-retention-period = "6 months";
      };
    };
  };

  environment.persistence."/persist".directories = [
    "/var/lib/atticd"
  ];

  sops.secrets.atticd-key.sopsFile = ../secrets.yaml;
}
