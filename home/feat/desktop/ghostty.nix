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

  programs.ghosstty = {
    enable = true;
    enableFishIntegration = true;
    settings = {

    };
    themes = {
      catppuccin-mocha = {
        background = "1e1e2e";
        cursor-color = "f5e0dc";
        foreground = "cdd6f4";
        palette = [
          "0=#45475a"
          "1=#f38ba8"
          "2=#a6e3a1"
          "3=#f9e2af"
          "4=#89b4fa"
          "5=#f5c2e7"
          "6=#94e2d5"
          "7=#bac2de"
          "8=#585b70"
          "9=#f38ba8"
          "10=#a6e3a1"
          "11=#f9e2af"
          "12=#89b4fa"
          "13=#f5c2e7"
          "14=#94e2d5"
          "15=#a6adc8"
        ];
        selection-background = "353749";
        selection-foreground = "cdd6f4";
      };
    };
  };
}
#   };
#     settings = {
#       keyboard.bindings = [
#         {
#           key = "N";
#           mods = "Control|Shift";
#           action = "SpawnNewInstance";
#         }
#       ];
#       font = {
#         size = config.fontProfiles.monospace.size;
#         normal = {
#           family = config.fontProfiles.monospace.name;
#           style = "Medium";
#         };
#       };
#       window = {
#         padding = {
#           x = 24;
#           y = 26;
#         };
#       };
#       colors = rec {
#         primary = {
#           background = config.colorscheme.colors.surface;
#           foreground = config.colorscheme.colors.on_surface;
#         };
#         normal = {
#           black = config.colorscheme.colors.surface_dim;
#           white = config.colorscheme.colors.on_surface;
#           red = config.colorscheme.colors.red;
#           green = config.colorscheme.colors.green;
#           yellow = config.colorscheme.colors.yellow;
#           blue = config.colorscheme.colors.blue;
#           magenta = config.colorscheme.colors.magenta;
#           cyan = config.colorscheme.colors.cyan;
#         };
#
#         # TODO make actual bright variants
#         bright = normal // {
#           black = config.colorscheme.colors.on_surface_variant;
#         };
#       };
#     };
#   };
# }
