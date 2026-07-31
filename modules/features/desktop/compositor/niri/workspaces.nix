{
  flake.homeModules.niriWorkspaces =
    { lib, config, ... }:
    {
      programs.niri.settings.workspaces = {
        # Holds the floating scratchpad terminal while it's hidden.
        scratch = { };
      }
      // lib.mapAttrs (
        _: output: lib.optionalAttrs (output != null) { open-on-output = output; }
      ) config.preferences.workspaces;
    };
}
