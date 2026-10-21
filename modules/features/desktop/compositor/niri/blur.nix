{ inputs, ... }:
{
  flake.homeModules.niriBlur =
    { options, ... }:
    let
      inherit (inputs.niri.lib.kdl) node leaf;
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
        (node "window-rule"
          [ ]
          [
            (leaf "match" { app-id = "^com\\.mitchellh\\.ghostty$"; })
            (node "background-effect" [ ] [ (leaf "blur" true) ])
          ]
        )
      ];
    };
}
