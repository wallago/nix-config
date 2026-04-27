{ config, lib }:
{
  vfr = true; # Variable Refresh Rate
  close_special_on_empty = true;
  focus_on_activate = true;
  on_focus_under_fullscreen = 2;
  disable_hyprland_logo = true;
  disable_splash_rendering = true;
  enable_swallow = true;
  swallow_regex = "(?i)(${
    lib.concatMapStringsSep "|" (lib.removeSuffix ".desktop")
      config.xdg.mimeApps.defaultApplications."x-scheme-handler/terminal"
  })";

}
