{ config, lib }: {
  vfr = true; # Variable Refresh Rate
  close_special_on_empty = true;
  focus_on_activate = true;
  new_window_takes_over_fullscreen = 2; # Unfullscreen when opening something
  disable_hyprland_logo = true;
  disable_splash_rendering = true;
  enable_swallow = true;
  swallow_regex = "(?i)(${
      lib.concatMapStringsSep "|" (lib.removeSuffix ".desktop")
      config.xdg.mimeApps.defaultApplications."x-scheme-handler/terminal"
    })";

}
