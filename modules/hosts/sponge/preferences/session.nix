{
  flake.homeModules.preferencesSessionSponge =
    let
      notesCmd = [
        "ghostty"
        "--title=notes"
        "--working-directory=/home/wallago"
        "-e"
        "vi"
        "./Notes"
        "-c"
        "Telekasten find_notes"
      ];
      webPerso = [
        "zen-beta"
        "--name=zen-perso"
        "--class=zen-perso"
        "-P"
        "perso"
        "--new-instance"
      ];
      rssCmd = [
        "ghostty"
        "--title=rss"
        "-e"
        "eilmeldung"
      ];
      webWorkCmd = [
        "zen-beta"
        "--name=zen-work"
        "--class=zen-work"
        "-P"
        "work"
        "--new-instance"
      ];
      mailCmd = [
        "ghostty"
        "--title=matcha"
        "-e"
        "matcha"
      ];
      expenseTrackerCmd = [
        "ghostty"
        "--title=bagels"
        "-e"
        "bagels"
      ];
      homeTermCmd = [
        "ghostty"
        "--title=home"
        "--working-directory=/home/wallago/"
      ];
    in
    {
      preferences.session = [
        {
          command = notesCmd;
          matchAppId = "com.mitchellh.ghostty";
          matchTitle = "notes";
          workspace = "productivity";
          maximized = true;
        }
        {
          command = webPerso;
          matchAppId = "zen-perso";
          workspace = "browser-perso";
          maximized = true;
        }
        {
          command = webWorkCmd;
          matchAppId = "zen-work";
          workspace = "browser-work";
          maximized = true;
        }
        {
          command = rssCmd;
          matchAppId = "com.mitchellh.ghostty";
          matchTitle = "rss";
          workspace = "productivity";
          maximized = true;
        }
        {
          command = homeTermCmd;
          matchAppId = "com.mitchellh.ghostty";
          matchTitle = "home";
          workspace = "home";
          maximized = true;
        }
        {
          command = mailCmd;
          matchAppId = "com.mitchellh.ghostty";
          matchTitle = "matcha";
          workspace = "productivity";
          maximized = true;
        }
        {
          command = expenseTrackerCmd;
          matchAppId = "com.mitchellh.ghostty";
          matchTitle = "bagels";
          workspace = "productivity";
          maximized = true;
        }
      ];
    };
}
