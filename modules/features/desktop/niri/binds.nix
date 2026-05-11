{
  flake.homeModules.niriBinds = {
    programs.niri.settings.binds =
      let
        column-up = "I";
        column-down = "E";
        workspace-up = "Y";
        workspace-down = "U";
        window-left = "N";
        window-right = "O";
      in
      {
        # Utils
        "Mod+Tab" = {
          action.toggle-overview = [ ];
          hotkey-overlay.title = "Overview";
        };
        "Mod+Q" = {
          action.close-window = [ ];
          hotkey-overlay.title = "Quit";
        };
        "Mod+Shift+Q" = {
          action.quit = [ ];
          hotkey-overlay.title = "Exit";
        };
        "Mod+Shift+Slash" = {
          action.show-hotkey-overlay = [ ];
          hotkey-overlay.title = "Help";
        };
        "Mod+${window-left}" = {
          action.focus-column-left = [ ];
          hotkey-overlay.title = "Focus Left";
        };
        "Mod+${window-right}" = {
          action.focus-column-right = [ ];
          hotkey-overlay.title = "Focus Right";
        };
        "Mod+${column-down}" = {
          action.focus-window-down = [ ];
          hotkey-overlay.title = "Focus Down";
        };
        "Mod+${column-up}" = {
          action.focus-window-up = [ ];
          hotkey-overlay.title = "Focus Top";
        };
        "Mod+${workspace-down}" = {
          action.focus-workspace-down = [ ];
          hotkey-overlay.title = "Focus Down Workspace";
        };
        "Mod+${workspace-up}" = {
          action.focus-workspace-up = [ ];
          hotkey-overlay.title = "Focus Up Workspace";
        };
        "Mod+V" = {
          action.toggle-window-floating = [ ];
          hotkey-overlay.title = "Toggle Floating";
        };
        "Mod+Shift+V" = {
          action.switch-focus-between-floating-and-tiling = [ ];
          hotkey-overlay.title = "Toggle Focus Floating";
        };

        # Layout Behavior
        "Mod+F" = {
          action.maximize-column = [ ];
          hotkey-overlay.title = "Expand";
        };
        "Mod+Shift+F" = {
          action.fullscreen-window = [ ];
          hotkey-overlay.title = "Fullscreen";
        };
        "Mod+R" = {
          action.switch-preset-column-width = [ ];
          hotkey-overlay.title = "Rotate Width";
        };
        "Mod+Shift+${window-left}" = {
          action.move-column-left = [ ];
          hotkey-overlay.title = "Switch Left";
        };
        "Mod+Shift+${window-right}" = {
          action.move-column-right = [ ];
          hotkey-overlay.title = "Switch Right";
        };
        "Mod+Shift+${column-down}" = {
          action.move-window-down = [ ];
          hotkey-overlay.title = "Switch Down";
        };
        "Mod+Shift+${column-up}" = {
          action.move-window-up = [ ];
          hotkey-overlay.title = "Switch Top";
        };
        "Mod+Shift+${workspace-down}" = {
          action.move-column-to-workspace-down = [ ];
          hotkey-overlay.title = "Move To Down Workspace";
        };
        "Mod+Shift+${workspace-up}" = {
          action.move-column-to-workspace-up = [ ];
          hotkey-overlay.title = "Move To Up Workspace";
        };
        "Mod+BracketLeft" = {
          action.consume-or-expel-window-left = [ ];
          hotkey-overlay.title = "Move Left";
        };
        "Mod+BracketRight" = {
          action.consume-or-expel-window-right = [ ];
          hotkey-overlay.title = "Move Right";
        };
        "Mod+C" = {
          action.center-column = [ ];
          hotkey-overlay.title = "Center Column";
        };

        # Apps
        "Mod+Return" = {
          action.spawn = "ghostty";
          hotkey-overlay.title = "Terminal";
        };
        "Mod+D" = {
          action.spawn = "fuzzel";
          hotkey-overlay.title = "Menu";
        };
        "Mod+Escape" = {
          action.spawn = "qylock";
          hotkey-overlay.title = "Lock";
        };
        "Mod+B" = {
          action.spawn = "zen-beta";
          hotkey-overlay.title = "Browser";
        };
      };
  };
}
