{ config, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${config.wallpaper}" ];
      wallpaper = [
        {
          monitor = "";
          path = "${config.wallpaper}";
          fit_mode = "cover";
        }
      ];
    };
  };
}
