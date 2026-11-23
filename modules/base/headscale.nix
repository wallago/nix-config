{
  flake.nixosModules.headscaleServerOptions =
    { lib, ... }:
    {
      options.preferences.headscale.server = {
        port = lib.mkOption {
          type = lib.types.port;
          description = "Local port Headscale listens on, behind nginx";
        };
      };
    };

  flake.nixosModules.headscaleClientOptions =
    { lib, ... }:
    {
      options.preferences.headscale.client = {
        authKeyFile = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Pre-auth key file used to join on first boot (null = join by hand)";
        };
        hostName = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Node name on the network (e.g. 4835-corolla)";
        };
      };
    };
}
