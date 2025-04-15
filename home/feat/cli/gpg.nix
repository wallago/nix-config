{ pkgs, config, ... }:
let
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  # GnuPG private key agent
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    enableFishIntegration = true;
    sshKeys = [ "7D03D56D2750F82854633104369968155A8320A4" ]; # Keygrip of your YubiKey GPG key
    pinentryPackage = pkgs.pinentry-tty;
  };

  home.packages = with pkgs; [ pinentry-tty ];

  # GPG system-wide
  programs.gpg = {
    enable = true;
    settings = {
      # "TOFU" = Trust On First Use
      # "PGP" = classic PGP Web of Trust
      trust-model = "tofu+pgp";
    };
    publicKeys = [
      {
        source = ../../pgp.asc;
        trust = 5;
      }
    ];
  };

  # GPG agent is started automatically when you log in using the Fish shell
  programs.fish.loginShellInit = ''
    gpgconf --launch gpg-agent
  '';

  systemd.user.services = {
    # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
    # So that SSH config does not have to know the UID
    link-gnupg-sockets = {
      Unit = {
        Description = "link gnupg sockets from /run to /home";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
        ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
        RemainAfterExit = true;
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
