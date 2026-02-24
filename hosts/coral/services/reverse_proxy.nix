{ config, ... }:
let
  ssl = {
    henrotte = {
      domain = "henrotte.xyz";
      crt = config.sops.secrets."henrotte.xyz-ssl-crt".path;
      key = config.sops.secrets."henrotte.xyz-ssl-key".path;
    };
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
      "markeeper.${ssl.wallago.domain}" = {
        enableACME = false;
        forceSSL = true;
        sslCertificate = ssl.wallago.crt;
        sslCertificateKey = ssl.wallago.key;
        locations."/".proxyPass = "http://127.0.0.1:5501";
      };
      "rewind.${ssl.wallago.domain}" = {
        enableACME = false;
        forceSSL = true;
        sslCertificate = ssl.wallago.crt;
        sslCertificateKey = ssl.wallago.key;
        locations."/".proxyPass = "http://127.0.0.1:5502";
      };
      "rss.${ssl.wallago.domain}" = {
        enableACME = false;
        forceSSL = true;
        sslCertificate = ssl.wallago.crt;
        sslCertificateKey = ssl.wallago.key;
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
