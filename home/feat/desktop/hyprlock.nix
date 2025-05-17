{ config, ... }:
let
  inherit (config) colorscheme;
  c = colorscheme.colors;
  toRGBA = color: "rgba(${builtins.substring 1 6 color}ff)";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };
      background = {
        path = "${config.wallpaper}";
        blur_passes = 3;
        blur_size = 8;
      };
      input-field = {
        size = "300, 50";
        position = "0, -120";
        font_color = toRGBA c.primary;
        font_family = "${config.fontProfiles.regular.name}";
        dots_center = true;
        inner_color = toRGBA c.surface;
        outer_color = toRGBA c.primary;
        outline_thickness = 3;
        check_color = toRGBA c.blue;
        fail_color = toRGBA c.red;
        placeholder_text = "<span>Password...</span>";
        rounding = 4;
      };
      label = {
        text = "Hi there, $USER";
        color = toRGBA c.on_surface;
        font_size = config.fontProfiles.regular.size + 3;
        font_family = "${config.fontProfiles.regular.name}";
        position = "0, 80";
        halign = "center";
        valign = "center";
      };
    };
  };
}
