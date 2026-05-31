{
  flake.nixosModules.userOptions =
    { lib, ... }:
    {
      options.preferences = {
        host.name = lib.mkOption {
          description = "Machine hostname";
          type = lib.types.str;
        };
        user = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "wallago";
          };
          authorizedSshKeys = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
          };
          keyboard = lib.mkOption {
            type = lib.types.submodule {
              options = {
                layout = lib.mkOption {
                  type = lib.types.str;
                  default = "us";
                };
                variant = lib.mkOption {
                  type = lib.types.str;
                  default = "colemak_dh";
                };
              };
            };
          };
        };
      };
    };

  flake.homeModules.userOptions =
    { lib, ... }:
    {
      options.preferences.user = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "wallago";
        };
        keyboard = lib.mkOption {
          type = lib.types.submodule {
            options = {
              layout = lib.mkOption {
                type = lib.types.str;
                default = "us";
              };
              variant = lib.mkOption {
                type = lib.types.str;
                default = "colemak_dh";
              };
            };
          };
        };
      };

      options.preferences.developer.enable = lib.mkEnableOption "Developer features";
    };
}
