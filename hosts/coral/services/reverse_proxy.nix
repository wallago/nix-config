{ ... }:
let domain = "henrotte.xyz";
in {
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
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
          proxyPass = "https://127.0.0.1:443";
          proxySslVerify = false;
          proxySetHeader = [
            "Host $host"
            "X-Real-IP $remote_addr"
            "X-Forwarded-For $proxy_add_x_forwarded_for"
            "X-Forwarded-Proto $scheme"
          ];
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
          proxyPass = "https://127.0.0.1:443";
          proxySslVerify = false;
          proxySetHeader = [
            "Host $host"
            "X-Real-IP $remote_addr"
            "X-Forwarded-For $proxy_add_x_forwarded_for"
            "X-Forwarded-Proto $scheme"
          ];
        };
      };
    };
  };
}
