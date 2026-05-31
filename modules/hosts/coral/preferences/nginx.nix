{
  flake.nixosModules.preferencesNginxCoral =
    { config, ... }:
    {
      preferences.nginx.reverseProxy.hosts = {
        "rss.wallago.xyz" = {
          sslCertificateKey = config.sops.secrets."wallago.xyz-ssl-key".path;
          sslCertificate = config.sops.secrets."wallago.xyz-ssl-crt".path;
          upstream = "http://127.0.0.1:5503";
        };
        "cache.wallago.xyz" = {
          sslCertificateKey = config.sops.secrets."wallago.xyz-ssl-key".path;
          sslCertificate = config.sops.secrets."wallago.xyz-ssl-crt".path;
          upstream = "http://127.0.0.1:5504";
        };
      };
    };
}
