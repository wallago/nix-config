{
  flake.nixosModules.skimmerOptions =
    { lib, ... }:
    {
      options.preferences.skimmer = {
        server = {
          address = lib.mkOption {
            type = lib.types.str;
            default = "127.0.0.1";
          };
          port = lib.mkOption {
            type = lib.types.port;
            default = 3000;
          };
        };
        webDir = lib.mkOption {
          type = lib.types.str;
          default = "/srv/skimmer-web";
        };
        firewallInterfaces = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };
      };
    };

}
