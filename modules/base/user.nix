{
  flake.nixosModules.userOptions =
    { lib, ... }:
    {
      options.preferences.user = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "wallago";
        };
        authorizedSshKeys = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };
        groups = {
          disk.enable = lib.mkEnableOption "raw block-device access (disk group) — high privilege, ~root-equivalent";
          serial.enable = lib.mkEnableOption "serial port access (dialout group) for flashing microcontrollers";
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
              startLayout = lib.mkOption {
                type = lib.types.ints.between 0 1;
                default = 1;
                description = "niri layout index active after login: 0 = plain us (QWERTY), 1 = layout/variant above.";
              };
              kagu.enable = lib.mkEnableOption "the Kagu split keyboard: its niri binds and cheatsheet pages";
            };
          };
        };
      };

      options.preferences.developer.enable = lib.mkEnableOption "Developer features";
    };
}
