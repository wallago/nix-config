{ pkgs, ... }: {
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
    text = ''
      wallago:l4B3tr+qm3fiZLz5yr5grjSl2+m3bPNncM3boLFOVZoBLaDdtRq9J269f29KVEUKfEQLbaT8t3qixZzg+vzcYw==,fyDGgAk9F6pdwGBXyuezaRA62uT8ToufyZyO/5KeoFRyyh9J41YEqtgN4VpJ/3bzSReequnwX74qEYakOeky2g==,es256,+presence
    '';
    mode = "0600";
  };
}
