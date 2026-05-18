{
  flake.homeModules.niriLayout = {
    programs.niri.settings.layout = {
      border = {
        enable = false;
        width = 1;
      };
      focus-ring.enable = true;
      shadow.enable = true;
      default-column-width.proportion = 0.66667;
      tab-indicator.place-within-column = true;
      gaps = 8;
    };
  };
}
