{
  flake.lib.niri.keybinds =
    { pkgs, lib }:
    let
      column-up = "I";
      column-down = "E";
      workspace-up = "Y";
      workspace-down = "U";
      window-left = "N";
      window-right = "O";
    in
    [
      # Navigation
      {
        mods = [ "Mod" ];
        key = "Tab";
        title = "Overview";
        category = "navigation";
        action.toggle-overview = [ ];
      }
      {
        mods = [ "Mod" ];
        key = window-left;
        title = "Focus Left";
        category = "navigation";
        action.focus-column-left = [ ];
      }
      {
        mods = [ "Mod" ];
        key = window-right;
        title = "Focus Right";
        category = "navigation";
        action.focus-column-right = [ ];
      }
      {
        mods = [ "Mod" ];
        key = column-up;
        title = "Focus Top";
        category = "navigation";
        action.focus-window-up = [ ];
      }
      {
        mods = [ "Mod" ];
        key = column-down;
        title = "Focus Down";
        category = "navigation";
        action.focus-window-down = [ ];
      }
      {
        mods = [
          "Mod"
          "Shift"
        ];
        key = window-left;
        title = "Switch Left";
        category = "navigation";
        action.move-column-left = [ ];
      }
      {
        mods = [
          "Mod"
          "Shift"
        ];
        key = window-right;
        title = "Switch Right";
        category = "navigation";
        action.move-column-right = [ ];
      }
      {
        mods = [
          "Mod"
          "Shift"
        ];
        key = column-up;
        title = "Switch Top";
        category = "navigation";
        action.move-window-up = [ ];
      }
      {
        mods = [
          "Mod"
          "Shift"
        ];
        key = column-down;
        title = "Switch Down";
        category = "navigation";
        action.move-window-down = [ ];
      }
      {
        mods = [
          "Mod"
          "Shift"
        ];
        key = "V";
        title = "Toggle Focus Floating";
        category = "navigation";
        action.switch-focus-between-floating-and-tiling = [ ];
      }

      # Monitors
      {
        mods = [
          "Mod"
          "Ctrl"
        ];
        key = window-left;
        title = "Focus Monitor Left";
        category = "monitors";
        action.focus-monitor-left = [ ];
      }
      {
        mods = [
          "Mod"
          "Ctrl"
        ];
        key = window-right;
        title = "Focus Monitor Right";
        category = "monitors";
        action.focus-monitor-right = [ ];
      }
      {
        mods = [
          "Mod"
          "Ctrl"
        ];
        key = column-up;
        title = "Focus Monitor Up";
        category = "monitors";
        action.focus-monitor-up = [ ];
      }
      {
        mods = [
          "Mod"
          "Ctrl"
        ];
        key = column-down;
        title = "Focus Monitor Down";
        category = "monitors";
        action.focus-monitor-down = [ ];
      }
      {
        mods = [
          "Mod"
          "Ctrl"
          "Shift"
        ];
        key = window-left;
        title = "Move To Monitor Left";
        category = "monitors";
        action.move-column-to-monitor-left = [ ];
      }
      {
        mods = [
          "Mod"
          "Ctrl"
          "Shift"
        ];
        key = window-right;
        title = "Move To Monitor Right";
        category = "monitors";
        action.move-column-to-monitor-right = [ ];
      }
      {
        mods = [
          "Mod"
          "Ctrl"
          "Shift"
        ];
        key = column-up;
        title = "Move To Monitor Up";
        category = "monitors";
        action.move-column-to-monitor-up = [ ];
      }
      {
        mods = [
          "Mod"
          "Ctrl"
          "Shift"
        ];
        key = column-down;
        title = "Move To Monitor Down";
        category = "monitors";
        action.move-column-to-monitor-down = [ ];
      }

      # Windows
      {
        mods = [ "Mod" ];
        key = "Q";
        title = "Quit";
        category = "windows";
        action.close-window = [ ];
      }
      {
        mods = [ "Mod" ];
        key = "F";
        title = "Expand";
        category = "windows";
        action.maximize-column = [ ];
      }
      {
        mods = [
          "Mod"
          "Shift"
        ];
        key = "F";
        title = "Fullscreen";
        category = "windows";
        action.fullscreen-window = [ ];
      }
      {
        mods = [ "Mod" ];
        key = "R";
        title = "Rotate Width";
        category = "windows";
        action.switch-preset-column-width = [ ];
      }
      {
        mods = [ "Mod" ];
        key = "V";
        title = "Toggle Floating";
        category = "windows";
        action.toggle-window-floating = [ ];
      }
      {
        mods = [ "Mod" ];
        key = "C";
        title = "Center Column";
        category = "windows";
        action.center-column = [ ];
      }
      {
        mods = [ "Mod" ];
        key = "BracketLeft";
        title = "Move Left";
        category = "windows";
        action.consume-or-expel-window-left = [ ];
      }
      {
        mods = [ "Mod" ];
        key = "BracketRight";
        title = "Move Right";
        category = "windows";
        action.consume-or-expel-window-right = [ ];
      }

      # Workspaces
      {
        mods = [ "Mod" ];
        key = workspace-up;
        title = "Focus Up Workspace";
        category = "workspaces";
        action.focus-workspace-up = [ ];
      }
      {
        mods = [ "Mod" ];
        key = workspace-down;
        title = "Focus Down Workspace";
        category = "workspaces";
        action.focus-workspace-down = [ ];
      }
      {
        mods = [
          "Mod"
          "Shift"
        ];
        key = workspace-up;
        title = "Move To Up Workspace";
        category = "workspaces";
        action.move-column-to-workspace-up = [ ];
      }
      {
        mods = [
          "Mod"
          "Shift"
        ];
        key = workspace-down;
        title = "Move To Down Workspace";
        category = "workspaces";
        action.move-column-to-workspace-down = [ ];
      }

      # Apps
      {
        mods = [ "Mod" ];
        key = "Return";
        title = "Terminal";
        category = "apps";
        action.spawn = "ghostty";
      }
      {
        mods = [ "Mod" ];
        key = "D";
        title = "Menu";
        category = "apps";
        action.spawn = "fuzzel";
      }
      {
        mods = [ "Mod" ];
        key = "B";
        title = "Browser";
        category = "apps";
        action.spawn = "zen-beta";
      }
      {
        mods = [ "Mod" ];
        key = "Escape";
        title = "Lock";
        category = "apps";
        action.spawn = "qylock";
      }
      {
        mods = [ "Mod" ];
        key = "P";
        title = "Screenshot";
        category = "apps";
        action.spawn = [
          "sh"
          "-c"
          ''
            ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp})" - | ${lib.getExe pkgs.satty} -f - --copy-command wl-copy
          ''
        ];
      }

      # System
      {
        mods = [
          "Mod"
          "Shift"
        ];
        key = "Slash";
        title = "Cheatsheet";
        category = "system";
        action = null;
      }
      {
        mods = [ "Mod" ];
        key = "Space";
        title = "Switch Keyboard Layout";
        category = "system";
        action.switch-layout = "next";
      }
      {
        mods = [
          "Mod"
          "Shift"
        ];
        key = "Q";
        title = "Exit";
        category = "system";
        action.quit = [ ];
      }
    ];
}
