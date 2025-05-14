{ config, ... }:
let inherit (config.colorscheme) colors;
in {
  services.mako = {
    enable = true;
    settings = {
      actions = true;
      border-color = "${colors.secondary}dd";
      border-radius = 4;
      border-size = 2;
      default-timeout = 12000;
      icons = true;
      markup = true;
      max-history = 50;
      max-icon-size = 32;
      outer-margin = "70, 0";
      text-color = "${colors.on_surface}dd";
      padding = "10,20";
      width = 400;
      height = 150;
      font = "${config.fontProfiles.regular.name} ${
          toString config.fontProfiles.regular.size
        }";
      anchor = "top-center";
      background-color = "${colors.surface}dd";
      layer = "overlay";
    };
  };
}
