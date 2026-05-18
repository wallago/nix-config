{
  flake.homeModules.preferencesSessionSponge = {
    preferences.session = [
      {
        command = [
          "zen-beta"
        ];
        matchAppId = "zen-beta";
        workspace = "browser";
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
    ];
  };
}
