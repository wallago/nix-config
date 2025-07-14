let
  rofi = "class:^(Rofi)$";
  steamGame = "class:steam_app_[0-9]*";
  steamBigPicture = "title:Steam Big Picture Mode";
  firefox = "class:firefox";
  firefoxPictureInPicture = "${firefox},title:Picture-in-Picture";
in [
  "syncfullscreen off, ${firefox}"
  "float, ${firefoxPictureInPicture}"
  "pin, ${firefoxPictureInPicture}"
  "noborder, ${firefoxPictureInPicture}"
  "noinitialfocus, ${firefoxPictureInPicture}"

  "float, ${rofi}"
  "pin, ${rofi}"
  "stayfocused, ${rofi}"
  "noanim, ${rofi}"
  "noborder, ${rofi}"
  "norounding, ${rofi}"
  "dimaround, ${rofi}"

  "immediate, ${steamGame}"
  "fullscreen, ${steamBigPicture}"
]
