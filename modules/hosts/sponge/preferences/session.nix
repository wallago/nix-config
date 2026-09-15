{ self, ... }: {
  flake.homeModules.preferencesSessionSponge =
    { pkgs, lib, ... }:
    let
      app = self.lib.app.command { inherit pkgs lib; };
    in
    {
      preferences.session = [
        {
          command = app.webSecondary;
          matchAppId = "zen.static";
          workspace = "browser-secondary";
          maximized = true;
        }
        {
          command = app.monitor;
          matchAppId = "com.mitchellh.ghostty";
          matchTitle = "monitor";
          workspace = "monitor";
          fullscreen = true;
        }
        {
          command = app.todo;
          matchAppId = "com.slot.todo";
          matchTitle = "todo";
          key = "1";
        }
        {
          command = app.note;
          matchAppId = "com.slot.notes";
          matchTitle = "notes";
          key = "2";
        }
        {
          command = app.mail;
          matchAppId = "com.slot.mail";
          matchTitle = "matcha";
          key = "3";
        }
        {
          command = app.webMain;
          matchAppId = "com.slot.zen.main";
          key = "4";
        }
        {
          command = app.resources;
          matchAppId = "com.slot.resources";
          matchTitle = "resources";
          key = "9";
        }
        {
          command = app.term;
          matchAppId = "com.slot.term";
          matchTitle = "term";
          key = "0";
        }
      ];
    };
}
