{ inputs, ... }:
{
  flake.homeModules.niriBlur =
    {
      options,
      config,
      lib,
      ...
    }:
    let
      inherit (inputs.niri.lib.kdl) node leaf;
      otherSlotIds = map (e: "^${lib.escapeRegex e.matchAppId}$") (
        lib.filter (
          e: e.key != null && e.matchAppId != null && !lib.hasPrefix "com.slot." e.matchAppId
        ) config.preferences.session
      );
      slotMatches = map (id: leaf "match" { app-id = id; }) otherSlotIds;
    in
    {
      # niri-flake's typed settings have no `blur` / `background-effect`
      # (niri 26.04), so append raw KDL to the document rendered from `settings`.
      programs.niri.config = options.programs.niri.config.default ++ [
        # Global tuning (niri defaults). Raise `offset` first, then `passes`.
        (node "blur"
          [ ]
          [
            (leaf "passes" 3)
            (leaf "offset" 3.0)
          ]
        )
        (node "window-rule" [ ] (
          [
            (leaf "match" { app-id = "^com\\.mitchellh\\.ghostty$"; })
            (leaf "match" { app-id = "^zen-beta$"; })
            (leaf "match" { app-id = "^zen\\.static$"; })
            (leaf "match" { app-id = "^com\\.slot\\."; })
          ]
          ++ slotMatches
          ++ [
            # Stop the focus ring from tinting through the transparent background.
            (leaf "draw-border-with-background" false)
            (node "background-effect" [ ] [ (leaf "blur" true) ])
          ]
        ))
      ];
    };
}
