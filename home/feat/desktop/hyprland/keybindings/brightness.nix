let backlight = "swayosd-client --brightness +0";
in [
  ",XF86MonBrightnessUp,exec,brightnessctl s +10%; ${backlight}"
  ",XF86MonBrightnessDown,exec,brightnessctl s 10%-; ${backlight}"
]
