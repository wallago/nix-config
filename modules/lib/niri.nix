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

      # Kagu keys (preferences.user.keyboard.kagu.enable): its Os layer sends
      # Super with arrows, its Hyp layer Ctrl+Alt+Shift+Super. `action`
      # overrides the bind's own one.
      os = [ "Mod" ];
      hyp = [
        "Mod"
        "Ctrl"
        "Alt"
        "Shift"
      ];
    in
    [
      # Navigation
      {
        mods = [ "Mod" ];
        key = "Tab";
        title = "Overview";
        category = "navigation";
        kagu = {
          mods = hyp;
          key = "Tab";
        };
        action.toggle-overview = [ ];
      }
      {
        mods = [ "Mod" ];
        key = window-left;
        title = "Focus Left";
        category = "navigation";
        kagu = {
          mods = os;
          key = "Left";
        };
        action.focus-column-left = [ ];
      }
      {
        mods = [ "Mod" ];
        key = window-right;
        title = "Focus Right";
        category = "navigation";
        kagu = {
          mods = os;
          key = "Right";
        };
        action.focus-column-right = [ ];
      }
      {
        mods = [ "Mod" ];
        key = column-up;
        title = "Focus Top";
        category = "navigation";
        kagu = {
          mods = os;
          key = "Up";
          action.focus-window-or-workspace-up = [ ];
        };
        action.focus-window-up = [ ];
      }
      {
        mods = [ "Mod" ];
        key = column-down;
        title = "Focus Down";
        category = "navigation";
        kagu = {
          mods = os;
          key = "Down";
          action.focus-window-or-workspace-down = [ ];
        };
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
        kagu = {
          mods = hyp;
          key = "Left";
        };
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
        kagu = {
          mods = hyp;
          key = "Right";
        };
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
        kagu = {
          mods = hyp;
          key = "Up";
          action.move-window-up-or-to-workspace-up = [ ];
        };
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
        kagu = {
          mods = hyp;
          key = "Down";
          action.move-window-down-or-to-workspace-down = [ ];
        };
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
        kagu = {
          mods = hyp;
          key = "V";
        };
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
        kagu = {
          mods = hyp;
          key = "Semicolon";
        };
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
        kagu = {
          mods = hyp;
          key = "Apostrophe";
        };
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
        kagu = {
          mods = hyp;
          key = "Z";
        };
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
        kagu = {
          mods = hyp;
          key = "X";
        };
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
        kagu = {
          mods = hyp;
          key = "F";
        };
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
        mods = [
          "Mod"
          "Shift"
        ];
        key = "P";
        title = "Power Menu";
        category = "apps";
        kagu = {
          mods = hyp;
          key = "P";
        };
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "powermenu"
          "toggle"
        ];
      }
      {
        mods = [ "Mod" ];
        key = "D";
        title = "Menu";
        category = "apps";
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "spotlight"
          "toggle"
        ];
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
        action.spawn = "qylock-lock";
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
            ${lib.getExe pkgs.wayfreeze} & freeze=$!
            sleep 0.1
            geom=$(${lib.getExe pkgs.slurp}) || { kill $freeze; exit 0; }
            img=$(mktemp --suffix .png)
            ${lib.getExe pkgs.grim} -g "$geom" "$img"
            kill $freeze
            ${lib.getExe pkgs.satty} -f "$img" --copy-command wl-copy
            rm -f "$img"
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
        kagu = {
          mods = hyp;
          key = "Q";
        };
        action.quit = [ ];
      }
    ];
}
