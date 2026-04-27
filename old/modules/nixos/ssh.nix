{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.ssh = {
    users = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            allowedKeys = mkOption {
              type = types.listOf types.path;
              description = "Allowed keys path";
            };
          };
        }
      );
      default = { };
      description = "SSH users";
    };
  };
}
