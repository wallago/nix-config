{ self, ... }: {
  flake.homeModules.zenPinsSocial =
    {
      mkPins,
      ...
    }:
    let
      id = "c6de089c-410d-4206-961d-ab11f988d40a";
      pins = mkPins {
        workspace = id;
        container = 5;
      } self.lib.zen.sites.social;
    in
    {
      programs.zen-browser.profiles = {
        default = {
          pinsForce = true; # Delete pins not declared here
          inherit pins;
        };
      };
    };
}
