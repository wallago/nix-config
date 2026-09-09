{
  flake.nixosModules.preferencesMinifluxCoral =
    { config, ... }:
    {
      preferences.miniflux = {
        url = "rss.wallago.xyz";
        port = 5503;
        adminCredentialsFile = config.sops.templates."miniflux-credentials".path;
      };
    };
}
