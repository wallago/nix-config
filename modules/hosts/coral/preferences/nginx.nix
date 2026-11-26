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
        "sync.wallago.xyz" = {
          sslCertificateKey = config.sops.secrets."wallago.xyz-ssl-key".path;
          sslCertificate = config.sops.secrets."wallago.xyz-ssl-crt".path;
          upstream = "http://127.0.0.1:8384";
        };
        "atuin.wallago.xyz" = {
          sslCertificateKey = config.sops.secrets."wallago.xyz-ssl-key".path;
          sslCertificate = config.sops.secrets."wallago.xyz-ssl-crt".path;
          upstream = "http://127.0.0.1:51488";
        };
        "todo.wallago.xyz" = {
          sslCertificateKey = config.sops.secrets."wallago.xyz-ssl-key".path;
          sslCertificate = config.sops.secrets."wallago.xyz-ssl-crt".path;
          upstream = "http://10.100.0.5:5505"; # Krill
        };
        "mind.wallago.xyz" = {
          sslCertificateKey = config.sops.secrets."wallago.xyz-ssl-key".path;
          sslCertificate = config.sops.secrets."wallago.xyz-ssl-crt".path;
          upstream = "http://10.100.0.5:5506"; # Krill
        };
        "vpn.wallago.xyz" = {
          # DNS only, so it needs a public cert, not the Cloudflare Origin one.
          useACMEHost = "vpn.wallago.xyz";
          upstream = "http://127.0.0.1:${toString cfg.headscale.server.port}";
          proxyWebsockets = true; # tailscale clients upgrade the connection
        };
      };
    };
}
