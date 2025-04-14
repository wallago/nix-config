{ config, ... }:
{
  # Set as default terminal
  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "Ghostty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "Ghostty.desktop";
    };
  };

  xdg.desktopEntries.Ghostty = {
    name = "Ghostty";
    exec = "ghostty";
    terminal = false;
    mimeType = [ "x-scheme-handler/terminal" ];
    categories = [
      "System"
      "Utility"
    ];
  };

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "custom";
      font-size = config.fontProfiles.monospace.size;
      font-family = config.fontProfiles.monospace.name;
      window-padding-x = "6";
      window-padding-y = "3";
      confirm-close-surface = false;
    };
    themes = {
      custom = {
        background = config.colorscheme.colors.surface;
        foreground = config.colorscheme.colors.on_surface;
        cursor-color = config.colorscheme.colors.primary;
        selection-background = config.colorscheme.colors.surface_container_high;
        selection-foreground = config.colorscheme.colors.on_surface;
        palette = [
          "0=${config.colorscheme.colors.surface}"
          "1=${config.colorscheme.colors.red}"
          "2=${config.colorscheme.colors.green}"
          "3=${config.colorscheme.colors.yellow}"
          "4=${config.colorscheme.colors.blue}"
          "5=${config.colorscheme.colors.magenta}"
          "6=${config.colorscheme.colors.cyan}"
          "7=${config.colorscheme.colors.on_surface}"
          "8=${config.colorscheme.colors.surface_container_highest}"
          "9=${config.colorscheme.colors.red_container}"
          "10=${config.colorscheme.colors.green_container}"
          "11=${config.colorscheme.colors.yellow_container}"
          "12=${config.colorscheme.colors.blue_container}"
          "13=${config.colorscheme.colors.magenta_container}"
          "14=${config.colorscheme.colors.cyan_container}"
          "15=${config.colorscheme.colors.on_primary_container}"
        ];
      };
    };
  };
}
