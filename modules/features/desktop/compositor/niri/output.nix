{
  flake.homeModules.niriOutput =
    { lib, config, ... }:
    {
      programs.niri.settings.outputs = lib.mapAttrs (_: m: {
        inherit (m)
          mode
          scale
          position
          ;
      }) config.preferences.monitors;
    };
}
