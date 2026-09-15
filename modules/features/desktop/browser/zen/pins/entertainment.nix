{ self, ... }: {
  flake.homeModules.zenPinsEntertainment =
    {
      mkPins,
      ...
    }:
    let
      id = "c2a98414-f9a5-4c03-971c-f11a5133919d";
      pins = mkPins {
        workspace = id;
        container = 1;
      } self.lib.zen.sites.entertainment;
    in
    {
      programs.zen-browser.profiles = {
        secondary = {
          pinsForce = true; # Delete pins not declared here
          inherit pins;
        };
      };
    };
}
