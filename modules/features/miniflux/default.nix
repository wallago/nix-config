{ self, ... }:
{
  flake.nixosModules.miniflux =
    { config, pkgs, ... }:
    let
      cfg = config.preferences.miniflux;
    in
    {
      imports = [
        self.nixosModules.minifluxOptions
      ];

      services.miniflux = {
        enable = true;
        inherit (cfg) adminCredentialsFile;
        config = {
          LISTEN_ADDR = "127.0.0.1:${toString cfg.port}";
          BASE_URL = "https://${cfg.url}";
        };
      };

      services.postgresqlBackup = {
        enable = true;
        databases = [ "miniflux" ];
        startAt = "*-*-* 03:00:00"; # daily 03:00
        location = "/persist/backups/postgresql";
        compression = "zstd";
      };

      systemd.services.miniflux-seed = {
        description = "Seed miniflux feeds from OPML";
        after = [ "miniflux.service" ];
        requires = [ "miniflux.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          EnvironmentFile = cfg.adminCredentialsFile;
        };
        script = ''
          for i in $(seq 1 30); do
            ${pkgs.curl}/bin/curl -sf http://127.0.0.1:${toString cfg.port}/healthcheck && break
            sleep 2
          done
          ${pkgs.curl}/bin/curl -sf -u "$ADMIN_USERNAME:$ADMIN_PASSWORD" \
            -X POST http://127.0.0.1:${toString cfg.port}/v1/import \
            --data-binary @${./feeds.opml}
        '';
      };
    };
}
