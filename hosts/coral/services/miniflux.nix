{ config, ... }:
let
  miniflux-admin-credentials = config.sops.secrets."miniflux-admin-credentials".path;
in
{
  services.miniflux = {
    enable = true;
    adminCredentialsFile = miniflux-admin-credentials;
    config = {
      LISTEN_ADDR = "127.0.0.1:5503";
      BASE_URL = "https://rss.henrotte.xyz";
    };
  };

  sops.secrets."miniflux-admin-credentials" = {
    sopsFile = ../secrets.yaml;
    format = "yaml";
  };
}
