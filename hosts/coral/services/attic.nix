{ config, lib, ... }:
let
  env-keys = config.sops.secrets.atticd-env-keys.path;
in
{
  services.atticd = {
    enable = true;
    environmentFile = env-keys;
    settings = {
      listen = "[::]:5504";
      api-endpoint = "https://cache.wallago.xyz/";
      allowed-hosts = [
        "cache.wallago.xyz"
        "localhost:5504"
      ];
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
      storage = {
        type = "local";
        path = "/var/lib/atticd/storage";
      };
    };
  };

  environment.persistence."/persist".directories = [
    "/var/lib/atticd"
  ];

  systemd.services.atticd.serviceConfig = {
    DynamicUser = lib.mkForce false;
  };

  users.users.atticd = {
    isSystemUser = true;
    group = "atticd";
    home = "/var/lib/atticd";
  };
  users.groups.atticd = { };

  systemd.services.atticd.serviceConfig.User = "atticd";

  sops.secrets.atticd-env-keys = {
    sopsFile = ../secrets.yaml;
    owner = "atticd";
  };
}
