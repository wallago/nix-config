{
  flake.nixosModules.yubikey = {
    # smartcard reader for the Yubikey
    services.pcscd.enable = true;

    # gpg-agent acts as the SSH agent; sets SSH_AUTH_SOCK in user sessions
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # pinentryPackage = pkgs.pinentry-gnome3;  # or pinentry-curses for TTY-only
    };
  };
}
