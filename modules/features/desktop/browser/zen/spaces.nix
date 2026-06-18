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
      perso = {
        "Personal" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40a";
          position = 1000;
          icon = "🏠";
          container = 1;
          theme = mkTheme 120 200 150;
        };
        "Dev" = {
          id = "78e3bba2-c29a-4573-977e-3477a56b0feb";
          position = 2000;
          icon = "💻";
          container = 2;
          theme = mkTheme 160 120 210;
        };
        "Shopping" = {
          id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
          position = 4000;
          icon = "💸";
          container = 4;
          theme = mkTheme 220 180 90;
        };
      };
      work = {
        "Work" = {
          id = "cdd10fab-4fc5-494b-9041-325e5759195b";
          position = 3000;
          icon = "💼";
          container = 3;
          theme = mkTheme 100 150 200;
        };
      };
    in
    {
      programs.zen-browser.profiles = {
        default = {
          spacesForce = true; # Delete spaces not declared here
          spaces = perso // work;
        };
        perso = {
          spacesForce = true; # Delete spaces not declared here
          spaces = perso;
        };
        work = {
          spacesForce = true; # Delete spaces not declared here
          spaces = work;
        };
      };
    };
}
