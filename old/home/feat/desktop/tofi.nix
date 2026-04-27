{ config, ... }:
let
  inherit (config) colorscheme;
  c = colorscheme.colors;
in {
  programs.tofi = {
    enable = true;
    settings = {
      background-color = "${c.surface}";
      text-color = "${c.on_surface}";
      selection-color = "${c.primary}";
      input-color = "${c.cyan}";
      border-width = 2;
      border-color = "${c.primary}";
      corner-radius = 4;
      hide-cursor = true;
      font = "${config.fontProfiles.regular.name}";
      font-size = config.fontProfiles.regular.size + 2;
      height = "60%";
      width = "60%";
      result-spacing = 10;
    };
  };
}
