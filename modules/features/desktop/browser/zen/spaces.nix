{
  flake.homeModules.zenSpaces =
    let
      mkTheme = r: g: b: {
        type = "gradient";
        colors = [
          {
            red = r;
            green = g;
            blue = b;
            algorithm = "floating";
            type = "explicit-lightness";
            lightness = 50;
          }
        ];
        opacity = 0.8;
        texture = 0.5;
      };
    in
    {
      programs.zen-browser.profiles = {
        default = {
          spacesForce = true; # Delete spaces not declared here
          spaceRouting = {
            defaultExternalRoute = "cdd10fab-4fc5-494b-9041-325e5759195b"; # external opens with no match
            routes."teams" = {
              reference = "teams.cloud.microsoft";
              openIn = "cdd10fab-4fc5-494b-9041-325e5759195b";
            };
          };
          spaces = {
            "Dev" = {
              id = "78e3bba2-c29a-4573-977e-3477a56b0feb";
              position = 2000;
              icon = "💻";
              container = 2;
              theme = mkTheme 160 120 210;
            };
            "Work" = {
              id = "cdd10fab-4fc5-494b-9041-325e5759195b";
              position = 3000;
              icon = "💼";
              container = 3;
              theme = mkTheme 100 150 200;
            };
            "Shopping" = {
              id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
              position = 4000;
              icon = "💸";
              container = 4;
              theme = mkTheme 220 180 90;
            };
            "Social" = {
              id = "c6de089c-410d-4206-961d-ab11f988d40a";
              position = 5000;
              icon = "👥";
              container = 5;
              theme = mkTheme 220 180 200;
            };
          };
        };
        secondary = {
          spacesForce = true; # Delete spaces not declared here
          spaceRouting = {
            defaultExternalRoute = "c2a98414-f9a5-4c03-971c-f11a5133919d"; # external opens with no match
            routes."twitch" = {
              reference = "twitch.tv";
              openIn = "c2a98414-f9a5-4c03-971c-f11a5133919d";
            };
          };
          spaces = {
            "Entertainment" = {
              id = "c2a98414-f9a5-4c03-971c-f11a5133919d";
              position = 1000;
              icon = "📹";
              container = 1;
              theme = mkTheme 120 200 150;
            };
          };
        };
      };
    };
}
