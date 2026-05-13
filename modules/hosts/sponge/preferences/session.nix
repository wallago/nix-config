{
  flake.homeModules.preferencesSessionSponge = {
    preferences.session = [
      {
        command = [
          "zen-beta"
        ];
        matchTitle = "zen-beta";
        workspace = "browser";
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
      }
    ];
  };
}
