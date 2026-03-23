{
  services.atticd = {
    enable = true;
    settings = {
      listen = "[::]:5504";
      api-endpoint = "https://cache.wallago.xyz/";
      allowed-hosts = [ "cache.wallago.xyz" ];
      soft-delete-caches = false;
      require-proof-of-possession = true;
      database.url = "postgresql://atticd@localhost/atticd";
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
}
