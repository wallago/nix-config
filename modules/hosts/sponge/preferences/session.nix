{
  flake.homeModules.preferencesSessionSponge = {
    preferences.session = [
      {
        command = [
          "ghostty"
          "--title=notes"
          "--working-directory=/home/wallago"
          "-e"
          "vi"
          "./Notes"
          "-c"
          "Telekasten find_notes"
        ];
        matchAppId = "com.mitchellh.ghostty";
        matchTitle = "notes";
        workspace = "notes";
        maximized = true;
      }
      {
        command = [
          "zen-beta"
          "--name=zen-perso"
          "--class=zen-perso"
          "-P"
          "perso"
          "--new-instance"
        ];
        matchAppId = "zen-perso";
        workspace = "browser-perso";
        maximized = true;
      }
      {
        command = [
          "zen-beta"
          "--name=zen-work"
          "--class=zen-work"
          "-P"
          "work"
          "--new-instance"
        ];
        matchAppId = "zen-work";
        workspace = "browser-work";
        maximized = true;
      }
      {
        command = [
          "ghostty"
          "--title=rss"
          "-e"
          "eilmeldung"
        ];
        matchAppId = "com.mitchellh.ghostty";
        matchTitle = "rss";
        workspace = "productivity";
        maximized = true;
      }
      {
        command = [
          "ghostty"
          "--title=config"
          "--working-directory=/home/wallago/nix-config"
          "-e"
          "vi"
        ];
        matchAppId = "com.mitchellh.ghostty";
        matchTitle = "config";
        workspace = "config";
        maximized = true;
      }
      {
        command = [
          "ghostty"
          "--title=matcha"
          "-e"
          "matcha"
        ];
        matchAppId = "com.mitchellh.ghostty";
        matchTitle = "matcha";
        workspace = "matcha";
        maximized = true;
      }
    ];
  };
}
