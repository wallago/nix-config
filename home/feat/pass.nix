{ pkgs, config, ... }: {
  programs.password-store = {
    enable = true;
    settings = { PASSWORD_STORE_DIR = "$HOME/.password-store"; };
    # extension for managing one-time-password (OTP) tokens
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  };

  services.pass-secret-service = {
    enable = true;
    storePath = "${config.home.homeDirectory}/.password-store";
  };

  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories =
      [ ".password-store/" ];
  };
}
