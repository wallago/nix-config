{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  rewind = {
    backend = "${inputs.rewind-backend.defaultPackage.${pkgs.system}}/bin/rewind-backend";
    frontend = "${inputs.rewind-frontend.defaultPackage.${pkgs.system}}";
  };
  rewind-db-passwd = config.sops.secrets.rewind-db-password.path;
  github-client-id = config.sops.secrets."github-client-id".path;
  github-client-secret = config.sops.secrets."github-client-secret".path;
  # cloudflare-purge-api-token =
  #   config.sops.secrets."cloudflare-purge-api-token".path;
  # cloudflare-zone-id = config.sops.secrets."cloudflare-zone-id".path;
  # curl = lib.getExe pkgs.curl;
  server-port = 5502;
in
{
  systemd.services.rewind = {
    description = "Run rewind app";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      LoadCredential = [
        "rewindDbPass:${rewind-db-passwd}"
        "githubClientID:${github-client-id}"
        "githubClientSecret:${github-client-secret}"
      ];
      ExecStart = pkgs.writeShellScript "run-rewind-backend" ''
        export GITHUB_CLIENT_ID=$(cat $CREDENTIALS_DIRECTORY/githubClientID)
        export GITHUB_CLIENT_SECRET=$(cat $CREDENTIALS_DIRECTORY/githubClientSecret)
        export DATABASE_URL=postgres://rewind:$(cat $CREDENTIALS_DIRECTORY/rewindDbPass)@localhost:5432
        export APP_PORT=${toString server-port}
        export FRONTEND="${rewind.frontend}"
        export MODE=PROD
        ${rewind.backend}
      '';
      Restart = "on-failure";
    };
  };

  # systemd.services.rewind-purge-cache = {
  #   description = "Purge Cloudflare cache after Rewind restart";
  #   after = [ "rewind.service" "network.target" ];
  #   requires = [ "rewind.service" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     LoadCredential = [
  #       "cloudflarePurgeApiToken:${cloudflare-purge-api-token}"
  #       "cloudflareZoneId:${cloudflare-zone-id}"
  #     ];
  #     ExecStart = pkgs.writeShellScript "purge-cloudflare-cache" ''
  #       CF_API_TOKEN=$(cat $CREDENTIALS_DIRECTORY/cloudflarePurgeApiToken)
  #       CF_ZONE_ID=$(cat $CREDENTIALS_DIRECTORY/cloudflareZoneId)
  #       echo "Purging Cloudflare cache for index.html..."
  #       ${curl} -s -X POST \
  #         -H "Authorization: Bearer $CF_API_TOKEN" \
  #         -H "Content-Type: application/json" \
  #         --data '{"purge_everything":true}' \
  #         "https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/purge_cache" \
  #         && echo "✅ Cloudflare cache purged" || echo "⚠️ Cloudflare purge failed"
  #     '';
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };

  sops.secrets = {
    rewind-db-password = {
      sopsFile = ../secrets.yaml;
      neededForUsers = true;
    };
    # "cloudflare-purge-api-token" = {
    #   sopsFile = ../secrets.yaml;
    #   neededForUsers = true;
    # };
    # "cloudflare-zone-id" = {
    #   sopsFile = ../secrets.yaml;
    #   neededForUsers = true;
    # };
    "github-client-id" = {
      sopsFile = ../secrets.yaml;
      neededForUsers = true;
    };
    "github-client-secret" = {
      sopsFile = ../secrets.yaml;
      neededForUsers = true;
    };
  };
}
