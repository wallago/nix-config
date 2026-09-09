{
  flake.homeModules.niriWindowRules =
    { lib, config, ... }:
    {
      programs.niri.settings.window-rules =
        lib.filter (r: r.matches != [ ]) (
          map (
            e:
            let
              hasMatch = e.matchAppId != null || e.matchTitle != null;
            in
            {
              matches = lib.optional hasMatch (
                lib.filterAttrs (_: v: v != null) {
                  app-id = e.matchAppId;
                  title = e.matchTitle;
                }
              );
            }
            // lib.optionalAttrs e.maximized { open-maximized = true; }
            // lib.optionalAttrs e.fullscreen { open-fullscreen = true; }
            // lib.optionalAttrs e.floating { open-floating = true; }
            // lib.optionalAttrs (e.workspace != null) { open-on-workspace = e.workspace; }
          ) config.preferences.session
        )
        ++ [
          {
            geometry-corner-radius = {
              top-left = 8.0;
              top-right = 8.0;
              bottom-left = 8.0;
              bottom-right = 8.0;
            };
            clip-to-geometry = true;
          }
          {
            matches = [
              {
                app-id = "^com\\.slot\\.";
              }
            ];
            open-floating = true;
            default-column-width = {
              proportion = 0.85;
            };
            default-window-height = {
              proportion = 0.85;
            };
          }
          {
            matches = [
              {
                app-id = "zen-beta";
                title = "^Picture-in-Picture$";
              }
            ];
            open-floating = true;
            default-column-width = {
              proportion = 0.2;
            };
            default-window-height = {
              proportion = 0.2;
            };
            default-floating-position = {
              x = 20;
              y = 20;
              relative-to = "bottom-right";
            };
          }
          {
            matches = [
              {
                app-id = "com.floaty.term";
              }
            ];
            open-floating = true;
            default-floating-position = {
              x = 0;
              y = 40;
              relative-to = "top";
            };
            default-column-width = {
              fixed = 900;
            };
            default-window-height = {
              fixed = 600;
            };
          }
        ];
    };
}
