{
  flake.homeModules.desktopOptions =
    { lib, ... }:
    let
      inherit (lib) mkOption types;
    in
    {

      options.preferences = {
        monitors = lib.mkOption {
          description = "Monitor Configuration";
          type = types.attrsOf (
            types.submodule {
              options = {
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
                wallpaper = mkOption {
                  type = types.nullOr types.path;
                  default = null;
                };
              };
            }
          );
        };
        workspaces = lib.mkOption {
          description = "Define workspaces";
          default = { };
          type = types.attrsOf (types.nullOr types.str);
        };
        session = lib.mkOption {
          description = "Startup apps with optional workspace routing";
          default = [ ];
          type = types.listOf (
            types.submodule {
              options = {
                command = mkOption { type = types.listOf types.str; };
                matchAppId = mkOption {
                  type = types.nullOr types.str;
                  default = null;
                };
                matchTitle = mkOption {
                  type = types.nullOr types.str;
                  default = null;
                };
                workspace = mkOption {
                  type = types.nullOr types.str;
                  default = null;
                };
                maximized = mkOption {
                  type = types.bool;
                  default = false;
                };
              };
            }
          );
        };
      };
    };
}
