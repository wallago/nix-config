{ pkgs, config, lib, ... }:
let
  hyprlandCfg = config.wayland.windowManager.hyprland;
  sshKeys = lib.mapAttrsToList (_: yk: yk.auth) config.yubikey;
  pubKeys = lib.mapAttrsToList (_: yk: {
    source = yk.pub.asc;
    trust = 5;
  }) config.yubikey;
in {
  # GnuPG private key agent
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true; # Allows GPG agent to act as an SSH agent
    enableExtraSocket =
      true; # Creates a special-purpose socket (S.gpg-agent.extra)
    enableFishIntegration = true;
    sshKeys = sshKeys;
    pinentry.package =
      if hyprlandCfg.enable then pkgs.pinentry-qt else pkgs.pinentry-tty;
    defaultCacheTtl = 600;
    maxCacheTtl = 7200;
    defaultCacheTtlSsh = 600;
    maxCacheTtlSsh = 7200;
    verbose = true;
  };

  programs = let
    fixGpg =
      # bash
      ''
        gpgconf --launch gpg-agent
      '';
  in {
    # Start gpg-agent if it's not running or tunneled in
    # SSH does not start it automatically, so this is needed to avoid having to use a gpg command at startup
    # https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
    bash.profileExtra = fixGpg;
    fish.loginShellInit = fixGpg;
    zsh.loginExtra = fixGpg;
    nushell.extraLogin = fixGpg;

    gpg = {
      enable = true;
      settings = {
        # "TOFU" = trust On First Use
        # "PGP" = classic PGP Web of Trust
        trust-model = "tofu+pgp";
      };
      publicKeys = pubKeys;
    };
  };
}
