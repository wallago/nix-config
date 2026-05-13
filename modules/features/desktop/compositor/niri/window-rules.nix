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
            // lib.optionalAttrs (e.workspace != null) { open-on-workspace = e.workspace; }
          ) (lib.filter (e: e.workspace != null) config.preferences.session)
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
        ];
    };
}
