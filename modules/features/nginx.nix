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
        virtualHosts = lib.mapAttrs (
          _: host:
          {
            forceSSL = true;
            enableACME = false;
            inherit (host) useACMEHost;
          }
          // lib.optionalAttrs (host.useACMEHost == null) {
            inherit (host)
              sslCertificate
              sslCertificateKey
              ;
          }
          // {
            extraConfig = ''
              client_max_body_size ${host.clientMaxBodySize};
            ''
            + lib.optionalString (host.allowedNetworks or [ ] != [ ]) ''
              ${lib.concatMapStrings (network: "allow ${network};\n") host.allowedNetworks}
              deny all;
            '';
            locations."/" = {
              proxyPass = host.upstream;
              inherit (host) proxyWebsockets;
            };
          }
        ) cfg.hosts;
      };

      networking.firewall.allowedTCPPorts = [
        80
        443
      ];
    };
}
