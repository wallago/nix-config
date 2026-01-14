{ ... }:
let domain = "henrotte.xyz";
in {
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedUwsgiSettings = true;
    virtualHosts = {
      "markeeper.${domain}" = {
        listen = [
          {
            addr = "0.0.0.0";
            port = 80;
          }
          {
            addr = "0.0.0.0";
            port = 443;
          }
        ];
        enableACME = false;
        locations."/" = {
          proxyPass = "https://127.0.0.1:5501";
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
          '';
        };
      };
      "rewind.${domain}" = {
        listen = [
          {
            addr = "0.0.0.0";
            port = 80;
          }
          {
            addr = "0.0.0.0";
            port = 443;
          }
        ];
        enableACME = false;
        locations."/" = {
          proxyPass = "https://127.0.0.1:5502";
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
          '';
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

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
