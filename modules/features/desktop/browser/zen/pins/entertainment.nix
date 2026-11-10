{ self, ... }: {
  flake.homeModules.zenPinsEntertainment =
    {
      mkGroup,
      ...
    }:
    let
      id = "c2a98414-f9a5-4c03-971c-f11a5133919d";
      pins =
        mkGroup {
          name = "Media";
          id = "be4acb93-9ca2-4e09-b2ac-219f3434468f";
          workspace = id;
          container = 1;
          position = 100;
        } self.lib.zen.sites.dev.media
        // mkGroup {
          name = "Dofus";
          id = "b6abeb46-c398-49cf-ba09-d34e7b984444";
          workspace = id;
          container = 1;
          position = 200;
        } self.lib.zen.sites.dev.dofus;
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
