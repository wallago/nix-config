{
  flake.homeModules.niriLayout = {
    programs.niri.settings.layout = {
      border.enable = false;
      focus-ring.enable = true;
      shadow.enable = true;
      default-column-width.proportion = 0.5;
      tab-indicator.place-within-column = true;
      gaps = 8;
    };
  };
}
