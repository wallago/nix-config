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
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config.common.default = "*";
      };
    };

  flake.homeModules.niri = {
    imports = [
      self.homeModules.niriBinds
      self.homeModules.niriLayout
      self.homeModules.niriOutput
      self.homeModules.niriInput
      self.homeModules.niriSpawnAtStartup
      self.homeModules.niriWorkspaces
      self.homeModules.niriWindowRules
    ];

    programs.niri.settings = {
      prefer-no-csd = true;

      hotkey-overlay = {
        hide-not-bound = true;
        skip-at-startup = true;
      };

      clipboard.disable-primary = true;

      xwayland-satellite.enable = true;
    };
  };
}
