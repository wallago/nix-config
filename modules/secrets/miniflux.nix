{
  flake.nixosModules.secretsMiniflux =
    { config, ... }:
    {
      sops.secrets = {
        miniflux-credentials = { };
        "wallago.xyz-ssl-crt" = {
          owner = config.services.nginx.user;
          group = config.services.nginx.group;
        };
      };
    };
}
