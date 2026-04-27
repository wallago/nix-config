{ pkgs, lib, config, ... }: {
  services = {
    udev.packages = [ pkgs.yubikey-personalization ];
    pcscd.enable = true; # smartcard service
  };

  # NOTE: u2f => two-factor authentication
  security.pam = {
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
    u2f = {
      enable = true;
      settings = {
        cue = true;
        authfile = "/etc/u2f-mappings";
      };
    };
  };

  environment.etc."u2f-mappings" = {
    text = lib.concatStringsSep "\n" (lib.attrValues config.u2f.mappings);
    mode = "0600";
  };
}
