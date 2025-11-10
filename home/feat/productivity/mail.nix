{ config, pkgs, lib, ... }:
let
  oama = lib.getExe config.programs.oama.package;

  common = { name, mailbox, title }: {
    realName = name;
    userName = mailbox;
    address = mailbox;
    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
    };
    msmtp.enable = true;
    neomutt = {
      enable = true;
      mailboxName = "=== ${title} ===";
      extraMailboxes = [ "Drafts" "Junk" "Sent" "Trash" "[Gmail]/All Mail" ];
      extraConfig = ''
        set copy = no
      '';
    };
  };
  channels = {
    Inbox = {
      farPattern = "INBOX";
      nearPattern = "Inbox";
      extraConfig = {
        Create = "Near";
        Expunge = "Both";
      };
    };
    Archive = {
      farPattern = "[Gmail]/All Mail";
      nearPattern = "[Gmail]/All Mail";
      extraConfig = {
        Create = "Both";
        Expunge = "Both";
      };
    };
    Junk = {
      farPattern = "[Gmail]/Spam";
      nearPattern = "Junk";
      extraConfig = {
        Create = "Near";
        Expunge = "Both";
      };
    };
    Trash = {
      farPattern = "[Gmail]/Trash";
      nearPattern = "Trash";
      extraConfig = {
        Create = "Near";
        Expunge = "Both";
      };
    };
    Drafts = {
      farPattern = "[Gmail]/Drafts";
      nearPattern = "Drafts";
      extraConfig = {
        Create = "Near";
        Expunge = "Both";
      };
    };
    Sent = {
      farPattern = "[Gmail]/Sent Mail";
      nearPattern = "Sent";
      extraConfig = {
        Create = "Near";
        Expunge = "Both";
      };
    };
  };

in {
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [ "Mail/" ];
  };

  # IMAP4 and Maildir mailbox synchronizer
  programs.mbsync = {
    enable = true;
    package = pkgs.isync.override { withCyrusSaslXoauth2 = true; };
  };

  services.mbsync = {
    enable = true;
    package = config.programs.mbsync.package;
  };

  # SMTP client
  programs.msmtp.enable = true;

  accounts.email = {
    maildirBasePath = "Mail";
    accounts = {
      dev = let mailbox = "commandant.cousteau1997@gmail.com";
      in {
        primary = true;
        passwordCommand = "${oama} access ${mailbox}";
        flavor = "gmail.com";
        mbsync = {
          groups.usp.channels = channels;
          extraConfig.account.AuthMechs = "XOAUTH2";
        };
        imap.host =
          "imap.gmail.com"; # retrieving and managing emails on the mail server.
        smtp.host = "smtp.gmail.com"; # sending emails
        msmtp.extraConfig.auth = "oauthbearer";
      } // common {
        name = "Wallago";
        title = "Dev";
        inherit mailbox;
      };

      perso = let mailbox = "henrotte.hugo@gmail.com";
      in {
        passwordCommand = "${oama} access ${mailbox}";
        flavor = "gmail.com";
        mbsync = {
          groups.usp.channels = channels;
          extraConfig.account.AuthMechs = "XOAUTH2";
        };
        imap.host =
          "imap.gmail.com"; # retrieving and managing emails on the mail server.
        smtp.host = "smtp.gmail.com"; # sending emails
        msmtp.extraConfig.auth = "oauthbearer";
      } // common {
        name = "Hugo Henrotte";
        title = "Perso";
        inherit mailbox;
      };
    };
  };

  # Only run if gpg is unlocked
  systemd.user.services.mbsync.Service.ExecCondition =
    let gpgCmds = import ../cli/gpg-commands.nix { inherit pkgs config lib; };
    in ''
      /bin/sh -c "${gpgCmds.isUnlocked}"
    '';

  # Ensure 'createMaildir' runs after 'linkGeneration'
  home.activation = {
    createMaildir = lib.mkForce (lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      run mkdir -m700 -p $VERBOSE_ARG ${
        lib.concatStringsSep " " (lib.mapAttrsToList (_: v: v.maildir.absPath)
          config.accounts.email.accounts)
      }
    '');
  };

}
