{
  flake.nixosModules.syncthingOptions =
    { lib, ... }:
    {
      options.preferences.syncthing = {
        guiPasswordFile = lib.mkOption {
          type = lib.types.str;
          description = "Gui password";
        };
        cert = lib.mkOption {
          type = lib.types.str;
          description = "Certificate";
        };
        key = lib.mkOption {
          type = lib.types.str;
          description = "Private Key";
        };
        folders = lib.mkOption {
          type = lib.types.attrsOf (
            lib.types.submodule {
              options = {
                name = lib.mkOption {
                  type = lib.types.str;
                  description = "Folder name";
                };
                devices = lib.mkOption {
                  type = lib.types.attrsOf (
                    lib.types.submodule {
                      options = {
                        id = lib.mkOption {
                          type = lib.types.str;
                          description = "Syncthing device ID";
                        };
                        addresses = lib.mkOption {
                          type = lib.types.listOf lib.types.str;
                          default = [ "dynamic" ];
                          description = "How to reach this device";
                        };
                      };
                    }
                  );
                  default = { };
                  description = "Peer devices to sync with";
                };
              };
            }
          );
          default = { };
          description = "Folders to sync";
        };
      };
    };
}
