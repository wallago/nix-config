{ self, ... }: {
  flake.homeModules.zenPinsPerso =
    {
      mkPins,
      mkGroup,
      ...
    }:
    let
      id = "c6de089c-410d-4206-961d-ab11f988d40a";
      pins =
        mkPins {
          workspace = id;
          container = 1;
        } [ ]
        // mkGroup {
          name = "Entertainment";
          id = "56b387a8-d3cf-409a-961d-3b550be46ca7";
          workspace = id;
          container = 1;
          position = 200;
        } self.lib.zen.sites.perso.entertainment
        // mkGroup {
          name = "Social Network";
          id = "a59977b2-91b6-46e3-89a1-8848481b55b8";
          workspace = id;
          container = 1;
          position = 300;
        } self.lib.zen.sites.perso.social
        // mkGroup {
          name = "Misc";
          id = "4f2fc00a-bd41-4b8b-bc3e-772b22e06317";
          workspace = id;
          container = 1;
          position = 400;
        } self.lib.zen.sites.perso.misc;
    in
    {
      programs.zen-browser.profiles = {
        secondary = {
          pinsForce = true; # Delete pins not declared here
          pins = pins;
        };
      };
    };
}
