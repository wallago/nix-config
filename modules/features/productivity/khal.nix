{
  flake.homeModules.khal = { config, pkgs, ... }: {
    programs.vdirsyncer.enable = true;
    services.vdirsyncer.enable = true;

    accounts.calendar = {
      basePath = ".local/share/calendars";
      accounts.google = {
        remote.type = "google_calendar";
        local = {
          type = "filesystem";
          fileExt = ".ics";
        };
        vdirsyncer = {
          enable = true;
          collections = [
            "from a"
            "from b"
          ];
          metadata = [
            "color"
            "displayname"
          ]; # feeds your {calendar-color}
          conflictResolution = "remote wins";
          tokenFile = "${config.xdg.dataHome}/vdirsyncer/google_token";
          clientIdCommand = [
            "${pkgs.jq}/bin/jq"
            "-r"
            ".client_id"
            "/run/secrets/rendered/matcha-oauth_client_gmail.json"
          ];
          clientSecretCommand = [
            "${pkgs.jq}/bin/jq"
            "-r"
            ".client_secret"
            "/run/secrets/rendered/matcha-oauth_client_gmail.json"
          ];
        };
        khal = {
          enable = true;
          type = "discover";
        };
      };
    };

    programs.khal = {
      enable = true;
      settings = {
        default = {
          default_calendar = "henrotte.hugo@gmail.com";
          timedelta = "5d";
          highlight_event_days = true;
        };
        view = {
          agenda_event_format = "{calendar-color}{cancelled}{start-end-time-style} {title}{repeat-symbol}{reset}";
          theme = "dark";
          frame = "color";
          blank_line_before_day = true;
        };
        palette = {
          header = "white, black, bold, '#cdd6f4', '#1e1e2e'";
          "line header" = "white, black, bold, '#89b4fa', '#1e1e2e'";
          today = "white, black, bold, '#1e1e2e', '#a6e3a1'";
          "today focus" = "white, black, bold, '#1e1e2e', '#f9e2af'";
          "date header" = "white, black, bold, '#cba6f7', '#1e1e2e'";
          "date header focused" = "white, black, bold, '#1e1e2e', '#cba6f7'";
        };
      };
    };
  };
}
