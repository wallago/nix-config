{
  flake.homeModules.niriSpawnAtStartup =
    { config, ... }:
    {
      programs.niri.settings.spawn-at-startup = map (e: {
        command = e.command;
      }) config.preferences.session;
    };
}
