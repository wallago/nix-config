{ inputs, self, ... }:
{
  flake.nixosModules.niri = {
    programs.niri.enable = true;
  };

  flake.homeModules.niri =
    {
      lib,
      pkgs,
      osConfig,
      ...
    }:
    {
      imports = [
        inputs.niri.homeModules.config
        self.homeModules.niriBinds
        self.homeModules.niriLayout
        self.homeModules.niriOutput
        self.homeModules.niriInput
        self.homeModules.niriSpawnAtStartup
        self.homeModules.niriWorkspaces
        self.homeModules.niriWindowRules
        self.homeModules.niriSlots
      ];

      # niri-flake runs `niri validate` on config.kdl with this package.
      programs.niri.package = osConfig.programs.niri.package;

      programs.niri.settings = {
        prefer-no-csd = true;

        hotkey-overlay = {
          hide-not-bound = true;
          skip-at-startup = true;
        };

        clipboard.disable-primary = true;

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
      };
    };
}
