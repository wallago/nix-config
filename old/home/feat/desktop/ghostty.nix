{ config, ... }:
let
  inherit (config) colorscheme;
  c = colorscheme.colors;
in
{
  # Set as default terminal
  xdg = {
    mimeApps = {
      associations.added = {
        "x-scheme-handler/terminal" = "Ghostty.desktop";
      };
      defaultApplications = {
        "x-scheme-handler/terminal" = "Ghostty.desktop";
      };
    };
    desktopEntries.Ghostty = {
      name = "Ghostty";
      exec = "ghostty";
      terminal = false;
      mimeType = [ "x-scheme-handler/terminal" ];
      categories = [
        "System"
        "Utility"
      ];
    };
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
      keybind = [
        "ctrl+shift+k=scroll_page_lines:1"
        "ctrl+shift+j=scroll_page_lines:-1"
      ];
    };
    themes = {
      custom = {
        background = c.surface;
        foreground = c.on_surface;
        cursor-color = c.primary;
        cursor-text = c.surface;
        selection-background = c.secondary_container;
        selection-foreground = c.on_surface;
        palette = [
          "0=${c.surface}"
          "1=${c.red_container}"
          "2=${c.green_container}"
          "3=${c.yellow_container}"
          "4=${c.blue_container}"
          "5=${c.magenta_container}"
          "6=${c.cyan_container}"
          "7=${c.outline}"
          "8=${c.outline_variant}"
          "9=${c.red}"
          "10=${c.green}"
          "11=${c.yellow}"
          "12=${c.blue}"
          "13=${c.magenta}"
          "14=${c.cyan}"
          "15=${c.on_surface}"
        ];
      };
    };
  };
}
