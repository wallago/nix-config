{ self, ... }:
{
  flake.nixosModules.nginxReverseProxy =
    { config, lib, ... }:
    let
      cfg = config.preferences.nginx.reverseProxy;
    in
    {
      imports = [
        self.nixosModules.nginxReverseProxyOptions
      ];

      services.nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        recommendedOptimisation = true;
        recommendedUwsgiSettings = true;
        virtualHosts = lib.mapAttrs (_: host: {
          forceSSL = true;
          enableACME = false;
          inherit (host)
            sslCertificate
            sslCertificateKey
            ;
          locations."/".proxyPass = host.upstream;
        }) cfg.hosts;
      };

      networking.firewall.allowedTCPPorts = [
        80
        443
      ];
    };
}
