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

  # run pamu2fcfg with pam_u2f
  environment.etc."u2f-mappings" = {
    text = ''
      wallago:Ge4frHnYZmClZvjgXUiiSkUd2cubTHFrVQDe4AHUXe7yet0Yw2pkqSc9ZL7jiMQ1IhtfJikxRtWjCNMIFgDu3Q==,ks5uwCN0k7KGqDP5Qbwxl4hM3m/0RioASk7B6n+vXqXPhJTy+s1PgtbhLD6KYOmu2Lyjw84enH/Cg79zruOOug==,es256,+presence
    '';
    mode = "0600";
  };
}
