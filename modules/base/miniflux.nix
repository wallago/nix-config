{
  flake.nixosModules.minifluxOptions =
    { lib, ... }:
    {
      options.preferences.miniflux = {
        adminCredentialsFile = lib.mkOption {
          type = lib.types.str;
          description = "Admin credentials";
        };
        port = lib.mkOption {
          type = lib.types.port;
          description = "Server port";
        };
        url = lib.mkOption {
          type = lib.types.str;
          description = "Server url";
        };
      };
    };
}
