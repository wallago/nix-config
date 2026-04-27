{ lib, ... }:
let inherit (lib) mkOption types;
in {

  options.yubikey = mkOption {
    type = types.attrsOf (types.submodule ({ ... }: {
      options = {
        signing = mkOption {
          type = types.str;
          example = "XXXXXXXXXXXXXXXX";
          description = ''
            Set signing key.
          '';
        };
        auth = mkOption {
          type = types.str;
          example = "XXXXXXXXXXXXXXXX";
          description = ''
            Set auth key.
          '';
        };
        sshPub = mkOption {
          type = types.path;
          example = "/path/to/ssh.pub";
          description = ''
            Set path to SSH public key file.
          '';
        };
        pub.asc = mkOption {
          type = types.path;
          example = "/path/to/pub_key.asc";
          description = ''
            Set path to the ASCII-armored GPG public key file.
          '';
        };
      };
    }));
    default = { };
    description = "Named set of yubikey configuration";
  };
}
