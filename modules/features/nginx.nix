{ self, ... }:
{
  flake.nixosModules.nginxReverseProxy =
    {
      config,
      lib,
      hostName,
      ...
    }:
    let
      cfg = config.preferences.nginx.reverseProxy;
      hostModule = self.nixosModules."preferencesNginx${self.lib.capitalize hostName}";
    in
    {
      imports = [
        self.nixosModules.nginxReverseProxyOptions
        hostModule
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
          extraConfig = ''
            client_max_body_size ${host.clientMaxBodySize};
          '';
          locations."/".proxyPass = host.upstream;
        }) cfg.hosts;
      };

      networking.firewall.allowedTCPPorts = [
        80
        443
      ];
    };
}
