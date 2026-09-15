{
  flake.homeModules.zenPinsPerso =
    { mkPins, mkGroup, ... }:
    let
      id = "c6de089c-410d-4206-961d-ab11f988d40a";
      pins =
        mkPins {
          workspace = id;
          container = 1;
        } [ ]
        //
          mkGroup
            {
              name = "Entertainment";
              id = "56b387a8-d3cf-409a-961d-3b550be46ca7";
              workspace = id;
              container = 1;
              position = 200;
            }
            [
              {
                name = "Twitch";
                id = "327ca5d6-a577-4390-ad51-ef8947a83d82";
                url = "https://twitch.com";
              }
              {
                name = "Youtube";
                id = "7db410d2-dcdf-4c34-ba91-2e144093bebe";
                url = "https://youtube.com";
              }
              {
                name = "Canal";
                id = "8cf966af-e496-4d5a-b229-aa52f782b6cc";
                url = "https://www.canalplus.com/";
              }
              {
                name = "Deezer";
                id = "a9bd4fc5-1880-4c9e-9fa7-f333abc554f9";
                url = "https://www.deezer.com/";
              }
            ]
        //
          mkGroup
            {
              name = "Social Network";
              id = "a59977b2-91b6-46e3-89a1-8848481b55b8";
              workspace = id;
              container = 1;
              position = 300;
            }
            [
              {
                name = "Reddit";
                id = "3b354f4f-2704-4801-8f0a-684f88af8931";
                url = "https://reddit.com";
              }
              {
                name = "Whatsapp";
                id = "3dbc43fc-3d63-48e1-a353-f146de02e7e7";
                url = "https://web.whatsapp.com/";
              }
            ]
        //
          mkGroup
            {
              name = "Misc";
              id = "4f2fc00a-bd41-4b8b-bc3e-772b22e06317";
              workspace = id;
              container = 1;
              position = 400;
            }
            [
              {
                name = "Jinka";
                id = "ab21c5ca-c393-4f94-b87e-d8c57e445933";
                url = "https://www.jinka.fr/";
              }
            ];
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
