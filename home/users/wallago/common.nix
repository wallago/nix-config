{ inputs, pkgs, config, ... }: {
  imports = [ ../../feat/mail.nix ];

  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [ "Perso/" "Work/" ];
  };

  programs.git = {
    userName = "wallago";
    userEmail = "45556867+wallago@users.noreply.github.com";
  };

  programs.firefox.profiles.wallago = {
    extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
      ublock-origin
      browserpass
      vimium
      privacy-badger
      new-tab-override
    ];
  };

  accounts.email = {
    accounts.wallago = {
      primary = true;
      address = "commandant.cousteau1997@gmail.com";
      realName = config.programs.git.userName;
      gpg = {
        key = "8729F3B886177D5D"; # YubiKey 001 GPG signing key
        signByDefault = true;
      };
      signature = {
        showSignature = "append";
        text = ''
          ${config.accounts.email.accounts.wallago.realName}

          PGP: ${config.accounts.email.accounts.wallago.gpg.key}
        '';
      };
    };
  };
}
