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
                type = lib.types.str;
                description = "SSL certificate";
              };
              sslCertificateKey = lib.mkOption {
                type = lib.types.str;
                description = "SSL certificate key";
              };
              upstream = lib.mkOption {
                type = lib.types.str;
                description = "Address the / location proxies to";
              };
            };
          }
        );
      };
    };
}
