{ config, lib, ... }:
let
  allYubiKeySigningKeys = lib.concatStringsSep "," (
    lib.mapAttrsToList (_: yk: yk.signing) config.yubikey
  );
in
{
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.password-store";
      PASSWORD_STORE_KEY = allYubiKeySigningKeys;
    };
  };

  services.pass-secret-service = {
    enable = true;
  };

  home.persistence = {
    "/persist/".directories = [ ".password-store/" ];
  };
}
