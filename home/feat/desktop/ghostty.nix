{ config, ... }:
let
  inherit (config) colorscheme;
  c = colorscheme.colors;
in {
  # Set as default terminal
  xdg.mimeApps = {
    associations.added = { "x-scheme-handler/terminal" = "Ghostty.desktop"; };
    defaultApplications = { "x-scheme-handler/terminal" = "Ghostty.desktop"; };
  };

  xdg.desktopEntries.Ghostty = {
    name = "Ghostty";
    exec = "ghostty";
    terminal = false;
    mimeType = [ "x-scheme-handler/terminal" ];
    categories = [ "System" "Utility" ];
  };

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "custom";
      font-size = config.fontProfiles.monospace.size;
      font-family = config.fontProfiles.monospace.name;
      window-padding-x = "6";
      window-padding-y = "4";
      confirm-close-surface = false;
    };
    themes = {
      custom = {
        background = c.surface;
        foreground = c.on_surface;

        cursor-color = c.outline;
        cursor-text = c.surface;

        selection-background = c.surface_variant;
        selection-foreground = c.on_surface;

        palette = [
          "0=${c.surface_container}"
          "1=${c.red}"
          "2=${c.green}"
          "3=${c.yellow}"
          "4=${c.blue}"
          "5=${c.magenta}"
          "6=${c.cyan}"
          "7=${c.on_surface_variant}"
          "8=${c.surface_variant}"
          "9=${c.red_container}"
          "10=${c.green_container}"
          "11=${c.yellow_container}"
          "12=${c.blue_container}"
          "13=${c.magenta_container}"
          "14=${c.cyan_container}"
          "15=${c.surface_tint}"
        ];
      };
    };
  };
}
