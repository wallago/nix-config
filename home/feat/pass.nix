{ config, ... }: {
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.password-store";
      PASSWORD_STORE_KEY = config.yubikeys.primary.signing;
    };
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
