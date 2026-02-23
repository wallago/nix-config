[
  {
    name = "firefox-pip";
    "match:class" = "firefox";
    "match:title" = "^Picture-in-Picture$";
    float = "on";
    pin = "on";
    decorate = "off";
    no_initial_focus = "on";
    size = "(monitor_w*0.25) (monitor_h*0.25)";
    move = "(monitor_w*0.75) (monitor_h*0.75)";
  }
  {
    name = "firefox";
    "match:class" = "firefox";
    sync_fullscreen = "off";
  }
  {
    name = "dmenu";
    "match:class" = "^(tofi)$";
    float = "on";
    pin = "on";
    no_anim = "on";
    decorate = "off";
    stay_focused = "on";
  }
  {
    name = "steam";
    "match:class" = "steam_app_[0-9]*";
    immediate = "on";
  }
  {
    name = "steam-pip";
    "match:class" = "Steam Big Picture Mode";
    fullscreen = "on";
  }
]
