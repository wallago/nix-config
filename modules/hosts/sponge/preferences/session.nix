{
  flake.homeModules.preferencesSessionSponge =
    let
      notesCmd = [
        "ghostty"
        "--class=com.slot.notes"
        "--title=notes"
        "--working-directory=/home/wallago"
        "-e"
        "vi"
        "./sync-notes"
      ];
      mailCmd = [
        "ghostty"
        "--class=com.slot.mail"
        "--title=matcha"
        "-e"
        "matcha"
      ];
      # rssCmd = [
      #   "ghostty"
      #   "--title=rss"
      #   "-e"
      #   "eilmeldung"
      # ];
      # expenseTrackerCmd = [
      #   "ghostty"
      #   "--title=bagels"
      #   "-e"
      #   "bagels"
      # ];
      #       homeTermCmd = [
      #   "ghostty"
      #   "--title=home"
      #   "--working-directory=/home/wallago/"
      #   "-e"
      #   "vi"
      #   "./sync-pm/gateway.md"
      # ];

      webSecondary = [
        "zen-beta"
        "--name=zen-secondary"
        "--class=zen-secondary"
        "-P"
        "secondary"
        "--new-instance"
      ];
      webMainCmd = [
        "zen-beta"
        "--name=zen-main"
        "--class=zen-main"
        "--new-instance"
      ];
      monitorCmd = [
        "ghostty"
        "--title=monitor"
        "-e"
        "vi"
      ];
    in
    {
      preferences.session = [
        {
          command = webSecondary;
          matchAppId = "zen-secondary";
          workspace = "browser-secondary";
          maximized = true;
        }
        {
          command = webMainCmd;
          matchAppId = "zen-main";
          workspace = "browser-main";
          maximized = true;
        }
        {
          command = monitorCmd;
          matchAppId = "com.mitchellh.ghostty";
          matchTitle = "monitor";
          workspace = "monitor";
          fullscreen = true;
        }
        {
          command = notesCmd;
          matchAppId = "com.slot.notes";
          matchTitle = "notes";
          key = "1";
          floating = true;
        }
        {
          command = mailCmd;
          matchAppId = "com.slot.mail";
          matchTitle = "matcha";
          key = "2";
          floating = true;
        }
        # {
        #   command = rssCmd;
        #   matchAppId = "com.mitchellh.ghostty";
        #   matchTitle = "rss";
        #   workspace = "productivity";
        #   maximized = true;
        # }
        # {
        #   command = homeTermCmd;
        #   matchAppId = "com.mitchellh.ghostty";
        #   matchTitle = "home";
        #   workspace = "home";
        #   maximized = true;
        # }
        # {
        #   command = expenseTrackerCmd;
        #   matchAppId = "com.mitchellh.ghostty";
        #   matchTitle = "bagels";
        #   workspace = "productivity";
        #   maximized = true;
        # }
      ];
    };
}
