{
  flake.homeModules.niriInput = {
    programs.niri.settings.input = {
      keyboard.xkb = {
        layout = "us";
        variant = "colemak_dh";
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
