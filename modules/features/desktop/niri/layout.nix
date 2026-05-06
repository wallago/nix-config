{
  flake.homeModules.niriLayout = {
    programs.niri.settings.layout = {
      gaps = 8;
      center-focused-column = "never";
      preset-column-widths = [
        { proportion = 1. / 3.; }
        { proportion = 1. / 2.; }
        { proportion = 2. / 3.; }
      ];
      default-column-width = {
        proportion = 1. / 2.;
      };
      focus-ring = {
        enable = true;
        width = 2;
      };
    };
  };
}
