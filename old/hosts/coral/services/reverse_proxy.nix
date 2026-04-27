{ config, ... }:
let
  ssl = {
    wallago = {
      domain = "wallago.xyz";
      crt = config.sops.secrets."wallago.xyz-ssl-crt".path;
      key = config.sops.secrets."wallago.xyz-ssl-key".path;
    };
  };
in
{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedUwsgiSettings = true;
    virtualHosts = {
      # Miniflux
      "rss.${ssl.wallago.domain}" = {
        enableACME = false;
        forceSSL = true;
        sslCertificate = ssl.wallago.crt;
        sslCertificateKey = ssl.wallago.key;
        locations."/".proxyPass = "http://127.0.0.1:5503";
      };
      # Attic
      "cache.${ssl.wallago.domain}" = {
        enableACME = false;
        forceSSL = true;
        sslCertificate = ssl.wallago.crt;
        sslCertificateKey = ssl.wallago.key;
        locations."/" = {
          proxyPass = "http://127.0.0.1:5504";
          extraConfig = ''
            client_max_body_size 0;  # no limit, NARs can be big
          '';
        };
      };
      # CouchDB
      "obsidian.${ssl.wallago.domain}" = {
        enableACME = false;
        forceSSL = true;
        sslCertificate = ssl.wallago.crt;
        sslCertificateKey = ssl.wallago.key;
        locations."/".proxyPass = "http://127.0.0.1:5984";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  sops.secrets = {
    "wallago.xyz-ssl-crt" = {
      sopsFile = ../secrets.yaml;
      owner = "nginx";
      group = "nginx";
    };
    "wallago.xyz-ssl-key" = {
      sopsFile = ../secrets.yaml;
      owner = "nginx";
      group = "nginx";
    };
  };
}
