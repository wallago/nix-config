{ config, ... }:
let
  domain = "henrotte.xyz";
  ssl-crt = config.sops.secrets."henrotte.xyz-ssl-crt".path;
  ssl-key = config.sops.secrets."henrotte.xyz-ssl-key".path;
in
{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedUwsgiSettings = true;
    virtualHosts = {
      "markeeper.${domain}" = {
        enableACME = false;
        forceSSL = true;
        sslCertificate = ssl-crt;
        sslCertificateKey = ssl-key;
        locations."/".proxyPass = "http://127.0.0.1:5501";
      };
      "rewind.${domain}" = {
        enableACME = false;
        forceSSL = true;
        sslCertificate = ssl-crt;
        sslCertificateKey = ssl-key;
        locations."/".proxyPass = "http://127.0.0.1:5502";
      };
      "rss.${domain}" = {
        enableACME = false;
        forceSSL = true;
        sslCertificate = ssl-crt;
        sslCertificateKey = ssl-key;
        locations."/".proxyPass = "http://127.0.0.1:5503";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  sops.secrets = {
    "henrotte.xyz-ssl-crt" = {
      sopsFile = ../secrets.yaml;
      owner = "nginx";
      group = "nginx";
    };
    "henrotte.xyz-ssl-key" = {
      sopsFile = ../secrets.yaml;
      owner = "nginx";
      group = "nginx";
    };
  };
}
