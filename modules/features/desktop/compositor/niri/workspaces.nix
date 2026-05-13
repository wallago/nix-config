{
  flake.homeModules.niriWorkspaces =
    { lib, config, ... }:
    {
      programs.niri.settings.workspaces = lib.mapAttrs (
        name: output: lib.optionalAttrs (output != null) { open-on-output = output; }
      ) config.preferences.workspaces;
    };
}
