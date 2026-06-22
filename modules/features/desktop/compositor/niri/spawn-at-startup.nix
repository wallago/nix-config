{
  flake.homeModules.niriSpawnAtStartup =
    { config, ... }:
    {
      programs.niri.settings.spawn-at-startup =
        (map (e: { inherit (e) command; }) config.preferences.session)
        ++ [
          {
            command = [
              "niri"
              "msg"
              "action"
              "switch-layout"
              "1"
            ];
          }
        ];
    };
}
