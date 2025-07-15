{ pkgs, config, lib, ... }:
let hyprlandCfg = config.wayland.windowManager.hyprland;
in {
  # GnuPG private key agent
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true; # Allows GPG agent to act as an SSH agent
    enableExtraSocket =
      true; # Creates a special-purpose socket (S.gpg-agent.extra)
    enableFishIntegration = true;
    sshKeys = builtins.map (key: key.auth) (lib.attrValues config.yubikeys);
    pinentry.package =
      if hyprlandCfg.enable then pkgs.pinentry-qt else pkgs.pinentry-tty;
    defaultCacheTtl = 600;
    maxCacheTtl = 7200;
    defaultCacheTtlSsh = 600;
    maxCacheTtlSsh = 7200;
    verbose = true;
  };

  # GPG system-wide
  programs.gpg = {
    enable = true;
    settings = {
      # "TOFU" = trust On First Use
      # "PGP" = classic PGP Web of Trust
      trust-model = "tofu+pgp";
    };
    # NOTE: yubikey => for compatibility with pcscd
    scdaemonSettings = { disable-ccid = true; };
    publicKeys = builtins.map (key: {
      source = key.asc;
      trust = 5;
    }) (lib.attrValues config.yubikeys);
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
