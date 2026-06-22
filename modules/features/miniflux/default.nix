{ self, ... }:
{
  flake.nixosModules.miniflux =
    {
      config,
      pkgs,
      hostName,
      ...
    }:
    let
      cfg = config.preferences.miniflux;
      hostModule = self.nixosModules."preferencesMiniflux${self.lib.capitalize hostName}";
      sopsFile = ../../secrets/miniflux.yaml;
    in
    {
      imports = [
        self.nixosModules.minifluxOptions
        hostModule
      ];

      services.miniflux = {
        enable = true;
        inherit (cfg) adminCredentialsFile;
        config = {
          LISTEN_ADDR = "127.0.0.1:${toString cfg.port}";
          BASE_URL = "https://${cfg.url}";
          POLLING_FREQUENCY = 1; # scheduler runs every minute
          BATCH_SIZE = 1; # refresh ≤1 feed/min → ≤1 Reddit request/min
          POLLING_PARSING_ERROR_LIMIT = 0; # don't auto-disable a feed after a few 403s
          HTTP_CLIENT_USER_AGENT = "web:miniflux-selfhost:1.0";
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
            --data-binary @${config.sops.templates."miniflux-feeds.opml".path}
        '';
      };

      sops.templates."miniflux-feeds.opml".content =
        builtins.replaceStrings
          [ "@REDDIT_TOKEN@" "@REDDIT_USER@" ]
          [
            config.sops.placeholder."reddit-rss-token"
            config.sops.placeholder."reddit-rss-user"
          ]
          (builtins.readFile ./feeds.opml);

      sops.secrets = {
        reddit-rss-token = { inherit sopsFile; };
        reddit-rss-user = { inherit sopsFile; };
      };
    };
}
