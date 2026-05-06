{ inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      imports = [ inputs.niri.nixosModules.niri ];

      programs.niri = {
        enable = true;
        package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-stable;
      };

      xdg.portal = {
        enable = true;
        extraPortals = [ ];
      };
    };

  flake.homeModules.niri = {
    programs.niri.settings = {
      input = {
        keyboard.xkb = {
          layout = "us";
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
          dwt = true;
        };

        mouse.accel-profile = "flat";
        focus-follows-mouse.enable = false;
      };

      outputs."DP-1" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
        scale = 1.0;
        position = {
          x = 0;
          y = 0;
        };
      };

      layout = {
        gaps = 8;
        center-focused-column = "never";
        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
        ];
        default-column-width = {
          proportion = 1. / 2.;
        };
        focus-ring = {
          enable = true;
          width = 2;
        };
      };

      spawn-at-startup = [ ];

      binds = {
        "Mod+Return".action.spawn = "alacritty";
        "Mod+D".action.spawn = "fuzzel";
        "Mod+Q".action.close-window = [ ];

        "Mod+H".action.focus-column-left = [ ];
        "Mod+L".action.focus-column-right = [ ];
        "Mod+J".action.focus-window-down = [ ];
        "Mod+K".action.focus-window-up = [ ];

        "Mod+Shift+H".action.move-column-left = [ ];
        "Mod+Shift+L".action.move-column-right = [ ];

        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;

        "Mod+Shift+E".action.quit = [ ];
      };
    };
  };
}
