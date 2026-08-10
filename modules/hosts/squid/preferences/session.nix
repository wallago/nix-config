{
  flake.homeModules.preferencesSessionSquid =
    let
      notesCmd = [
        "ghostty"
        "--title=notes"
        "--working-directory=/home/wallago"
        "-e"
        "vi"
        "./Notes"
        "-c"
        "lua require('telekasten').goto_thisweek({ journal_auto_open = true })"
        "-c"
        "vsplit ./Notes/pickup-tasks.md"
      ];
      webSecondary = [
        "zen-beta"
        "--name=zen-secondary"
        "--class=zen-secondary"
        "-P"
        "secondary"
        "--new-instance"
      ];
      rssCmd = [
        "ghostty"
        "--title=rss"
        "-e"
        "eilmeldung"
      ];
      webMainCmd = [
        "zen-beta"
        "--name=zen-main"
        "--class=zen-main"
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
        "-e"
        "vi"
        "./sync-pm/gateway.md"
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
          command = webSecondary;
          matchAppId = "zen-secondary";
          workspace = "browser";
          maximized = true;
        }
        {
          command = webMainCmd;
          matchAppId = "zen-main";
          workspace = "browser";
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
