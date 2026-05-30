{ self, ... }:
{
  flake.nixosModules.miniflux =
    { config, ... }:
    let
      cfg = config.preferences.miniflux;
    in
    {
      imports = [
        self.nixosModules.minifluxOptions
      ];

      services.miniflux = {
        enable = true;
        inherit (cfg) adminCredentialsFile;
        config = {
          LISTEN_ADDR = "127.0.0.1:{cfg.port}";
          BASE_URL = "https://{cfg.url}";
        };
      };
    };
}
