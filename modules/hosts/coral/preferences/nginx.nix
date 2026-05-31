{
  flake.nixosModules.preferencesNginxCoral =
    { config, ... }:
    let
      cfg = config.preferences;
    in
    {
      preferences.nginx.reverseProxy.hosts = {
        "rss.wallago.xyz" = {
          sslCertificateKey = config.sops.secrets."wallago.xyz-ssl-key".path;
          sslCertificate = config.sops.secrets."wallago.xyz-ssl-crt".path;
          upstream = "http://127.0.0.1:${toString cfg.miniflux.port}";
        };
        "cache.wallago.xyz" = {
          sslCertificateKey = config.sops.secrets."wallago.xyz-ssl-key".path;
          sslCertificate = config.sops.secrets."wallago.xyz-ssl-crt".path;
          upstream = "http://127.0.0.1:${toString cfg.attic.port}";
          clientMaxBodySize = "0";
        };
      };
    };
}
