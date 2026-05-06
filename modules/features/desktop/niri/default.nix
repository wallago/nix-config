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

  flake.homeModules.niri = {
    imports = [
      self.homeModules.niriBinds
      self.homeModules.niriLayout
      self.homeModules.niriOutput
      self.homeModules.niriInput
    ];

    programs.niri.settings = {
      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
      ];
    };
  };
}
