{ lib, ... }:
let inherit (lib) mkOption types;
in {

  # options.disk = {
  #   path = mkOption {
  #     type = types.str;
  #     example = "/dev/sda";
  #     description = ''
  #       Set path to the disk device.
  #     '';
  #   };
  #   swapSize = mkOption {
  #     type = types.str;
  #     default = "8196M";
  #     description = ''
  #       Set size of the swap part.
  #     '';
  #   };
  # };
  # }
  options.yubikey = {
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
    description = "Named set of yubikey configuration";
  };
}
