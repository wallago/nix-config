{
  flake.nixosModules.atticOptions =
    { lib, ... }:
    {
      options.preferences.attic = {
        environmentFile = lib.mkOption {
          type = lib.types.str;
          description = "Environment file";
        };
        port = lib.mkOption {
          type = lib.types.port;
          description = "Server port";
        };
      };
    };
}
