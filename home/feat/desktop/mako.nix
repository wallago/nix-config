{ config, ... }:
let inherit (config.colorscheme) colors;
in {
  services.mako = {
    enable = true;
    font = "${config.fontProfiles.regular.name} ${
        toString config.fontProfiles.regular.size
      }";
    padding = "10,20";
    anchor = "top-center";
    width = 400;
    height = 150;
    defaultTimeout = 12000;
    backgroundColor = "${colors.surface}dd";
    borderColor = "${colors.secondary}dd";
    borderRadius = 4;
    borderSize = 2;
    icons = true;
    maxIconSize = 32;
    markup = true;
    actions = true;
    textColor = "${colors.on_surface}dd";
    layer = "overlay";
    extraConfig = ''
      max-history=50
      outer-margin=70, 0
    '';
  };
}
