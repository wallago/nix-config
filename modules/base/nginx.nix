{
  flake.nixosModules.nginxReverseProxyOptions =
    { lib, ... }:
    {
      options.preferences.nginx.reverseProxy.hosts = lib.mkOption {
        default = { };
        description = "Reverse-proxied virtual hosts";
        type = lib.types.attrsOf (
          lib.types.submodule {
            options = {
              sslCertificate = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "SSL certificate (unused when useACMEHost is set)";
              };
              sslCertificateKey = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "SSL certificate key (unused when useACMEHost is set)";
              };
              useACMEHost = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "Use this security.acme cert instead of sslCertificate/sslCertificateKey";
              };
              upstream = lib.mkOption {
                type = lib.types.str;
                description = "Address the / location proxies to";
              };
              proxyWebsockets = lib.mkOption {
                type = lib.types.bool;
                default = false;
                description = "Forward connection upgrades (WebSocket) to the upstream";
              };
              clientMaxBodySize = lib.mkOption {
                type = lib.types.str;
                default = "1m";
                description = "Max upload body size for this host (0 = unlimited)";
              };
              allowedNetworks = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [ ];
                description = "Network allowed to use this address.";
              };
            };
          }
        );
      };
    };
}
