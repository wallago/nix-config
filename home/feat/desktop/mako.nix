{ config, ... }:
let inherit (config.colorscheme) colors mode;
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
    borderSize = 2;
    defaultTimeout = 12000;
    backgroundColor = "${colors.surface}dd";
    borderColor = "${colors.secondary}dd";
    textColor = "${colors.on_surface}dd";
    layer = "overlay";
    extraConfig = ''
      max-history=50
    '';
  };
}
