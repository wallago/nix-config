{ inputs, pkgs, config, ... }: {
  imports = [ ../../feat/mail.nix ];

  programs.git = {
    userName = "wallago";
    userEmail = "45556867+wallago@users.noreply.github.com";
  };

  programs.firefox.profiles.yc = {
    extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
      ublock-origin
      browserpass
      vimium
      privacy-badger
      new-tab-override
    ];
  };

  accounts.email = {
    accounts.yc = {
      primary = true;
      address = "commandant.cousteau1997@gmail.com";
      realName = config.programs.git.userName;
      gpg = {
        key = "C6C581A860F158EB";
        signByDefault = true;
      };
      signature = {
        showSignature = "append";
        text = ''
          ${config.accounts.email.accounts.yc.realName}

          PGP: ${config.accounts.email.accounts.yc.gpg.key}
        '';
      };
    };
  };
}
