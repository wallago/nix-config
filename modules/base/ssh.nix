{
  flake.nixosModules.sshOptions =
    { lib, ... }:
    {
      options.preferences.ssh.authorizedSshKeys = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
    };
}
