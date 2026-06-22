{
  flake.homeModules.niriInput =
    { config, ... }:
    {
      programs.niri.settings.input = {
        keyboard.xkb = {
          layout = "us,${config.preferences.user.keyboard.layout}";
          variant = ",${config.preferences.user.keyboard.variant}";
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
          dwt = true;
        };

        mouse.accel-profile = "flat";
        focus-follows-mouse.enable = false;
      };
    };
}
