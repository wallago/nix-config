{
  flake.homeModules.desktopOptions =
    { lib, ... }:
    let
      inherit (lib) mkOption types;
    in
    {

      options.preferences.monitors = lib.mkOption {
        description = "Monitor Configuration";
        type = types.attrsOf (
          types.submodule {
            options = {
              enable = mkOption {
                type = types.bool;
                default = true;
              };
              primary = mkOption {
                type = types.bool;
                default = false;
              };

              mode = mkOption {
                type = types.submodule {
                  options = {
                    width = mkOption {
                      type = types.int;
                      example = 1920;
                    };
                    height = mkOption {
                      type = types.int;
                      example = 1080;
                    };
                    refresh = mkOption {
                      type = types.float;
                      default = 60.0;
                    };
                  };
                };
              };

              scale = mkOption {
                type = types.float;
                default = 1.0;
              };

              position = mkOption {
                type = types.submodule {
                  options = {
                    x = mkOption {
                      type = types.int;
                      default = 0;
                    };
                    y = mkOption {
                      type = types.int;
                      default = 0;
                    };
                  };
                };
                default = { };
              };

              workspace = mkOption {
                type = types.nullOr types.str;
                default = null;
              };
            };
          }
        );
      };
    };
}
