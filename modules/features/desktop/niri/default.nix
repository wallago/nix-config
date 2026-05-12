{ inputs, self, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      imports = [ inputs.niri.nixosModules.niri ];

      programs.niri = {
        enable = true;
        package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-stable;
      };

      xdg.portal = {
        enable = true;
        extraPortals = [ ];
      };
    };

  flake.homeModules.niri =
    { config, lib, ... }:
    {
      imports = [
        self.homeModules.niriBinds
        self.homeModules.niriLayout
        self.homeModules.niriOutput
        self.homeModules.niriInput
      ];

      programs.niri.settings = {
        spawn-at-startup = [
          { command = [ "noctalia-shell" ]; }
        ]
        ++ map (e: { command = e.command; }) config.preferences.session;

        workspaces = lib.mapAttrs (
          name: output: lib.optionalAttrs (output != null) { open-on-output = output; }
        ) config.preferences.workspace;

        window-rules = lib.filter (r: r.matches != [ ]) (
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
            // lib.optionalAttrs (e.workspace != null) { open-on-workspace = e.workspace; }
          ) (lib.filter (e: e.workspace != null) config.preferences.session)
        );
      };
    };
}
