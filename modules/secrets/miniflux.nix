{
  flake.nixosModules.secretsMiniflux =
    { config, ... }:
    {
      sops.secrets.miniflux-admin-password = { };

      sops.templates."miniflux-credentials".content = ''
        ADMIN_USERNAME=admin
        ADMIN_PASSWORD=${config.sops.placeholder.miniflux-admin-password}
      '';
    };
}
