{
  flake.homeModules.zenPinsWork =
    { mkPins, ... }:
    let
      id = "cdd10fab-4fc5-494b-9041-325e5759195b";
      pins =
        mkPins
          {
            workspace = id;
            container = 3;
            start = 102;
          }
          [
            {
              name = "Teams";
              id = "859d6d24-bb0b-4e3d-b3f6-65d50f135545";
              url = "https://teams.cloud.microsoft/";
            }
            {
              name = "GH";
              id = "505ce33f-df2f-4e54-8e1a-5ae0a16365e3";
              url = "http://192.168.5.16/ghci/index.php/Authentification";
            }
            {
              name = "Google Doc";
              id = "f2e3d2e1-ff5f-4415-afd9-a637eb1ac81d";
              url = "https://docs.google.com/document/d/1b8iTKnk9vJ2XjeNQwDScE9vk9-LYLUUlc8tWWTYrvDA/edit?pli=1&tab=t.0";
            }
          ];
    in
    {
      programs.zen-browser.profiles = {
        default = {
          pinsForce = true; # Delete pins not declared here
          pins = pins;
        };
      };
    };
}
