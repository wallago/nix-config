{
  flake.homeModules.niriWorkspaces =
    { lib, config, ... }:
    {
      programs.niri.settings.workspaces = lib.mapAttrs (
        _: output: lib.optionalAttrs (output != null) { open-on-output = output; }
      ) config.preferences.workspaces;
    };
}
