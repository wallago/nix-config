{ pkgs, ... }: {
  # GnuPG private key agent
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true; # Allows GPG agent to act as an SSH agent
    enableExtraSocket =
      true; # Creates a special-purpose socket (S.gpg-agent.extra)
    enableFishIntegration = true;
    sshKeys = [ "BFCFF7BFE837D391" ]; # YubiKey GPG auth key
    pinentry.package = pkgs.pinentry-tty;
    extraConfig = ''
      allow-loopback-pinentry
    '';
  };

  home.packages = with pkgs; [ pinentry-tty ];

  # GPG system-wide
  programs.gpg = {
    enable = true;
    settings = {
      # "TOFU" = trust On First Use
      # "PGP" = classic PGP Web of Trust
      trust-model = "tofu+pgp";
      # enable pinentry for neovim usage
      pinentry-mode = "loopback";
    };
    publicKeys = [{
      source = ../../pgp.asc;
      trust = 5;
    }];
  };

  # GPG agent is started automatically when you log in using the Fish shell
  programs.fish.loginShellInit = ''
    gpgconf --launch gpg-agent
  '';

  systemd.user.services = {
    # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
    # So that SSH config does not have to know the UID
    link-gnupg-sockets = {
      Unit = { Description = "link gnupg sockets from /run to /home"; };
      Service = {
        Type = "oneshot";
        ExecStart =
          "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
        ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
        RemainAfterExit = true;
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
