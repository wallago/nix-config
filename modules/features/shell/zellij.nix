{
  flake.homeModules.zellij = {
    programs.zellij = {
      enable = true;
      # started by hand with `zj`, not on every shell, so sessions never nest
      enableFishIntegration = false;

      settings = {
        theme = "catppuccin-mocha";
        # Ctrl g unlocks; fish and nvim keep every other Ctrl key
        default_mode = "locked";
        session_serialization = true;
        serialize_pane_viewport = true;
        show_startup_tips = false;
      };

      # NEIO replaces HJKL, matching the nvim binds
      extraConfig = ''
        keybinds {
            shared {
                unbind "Alt n" "Alt i" "Alt o"
                bind "Alt n" { MoveFocusOrTab "Left"; }
                bind "Alt e" { MoveFocus "Down"; }
                bind "Alt i" { MoveFocus "Up"; }
                bind "Alt o" { MoveFocusOrTab "Right"; }
                bind "Alt a" { NewPane; }
            }
            pane {
                unbind "n" "e" "i"
                bind "n" { MoveFocus "Left"; }
                bind "e" { MoveFocus "Down"; }
                bind "i" { MoveFocus "Up"; }
                bind "o" { MoveFocus "Right"; }
                bind "a" { NewPane; SwitchToMode "Locked"; }
                bind "b" { TogglePaneEmbedOrFloating; SwitchToMode "Locked"; }
            }
            tab {
                unbind "n" "i" "o"
                bind "n" { GoToPreviousTab; }
                bind "o" { GoToNextTab; }
                bind "a" { NewTab; SwitchToMode "Locked"; }
            }
            resize {
                bind "n" { Resize "Increase Left"; }
                bind "e" { Resize "Increase Down"; }
                bind "i" { Resize "Increase Up"; }
                bind "o" { Resize "Increase Right"; }
                bind "N" { Resize "Decrease Left"; }
                bind "E" { Resize "Decrease Down"; }
                bind "I" { Resize "Decrease Up"; }
                bind "O" { Resize "Decrease Right"; }
            }
            move {
                unbind "n"
                bind "n" { MovePane "Left"; }
                bind "e" { MovePane "Down"; }
                bind "i" { MovePane "Up"; }
                bind "o" { MovePane "Right"; }
                bind "Tab" { MovePane; }
            }
            scroll {
                unbind "e"
                bind "e" { ScrollDown; }
                bind "i" { ScrollUp; }
                bind "v" { EditScrollback; SwitchToMode "Locked"; }
            }
            search {
                bind "e" { ScrollDown; }
                bind "i" { ScrollUp; }
                bind "h" { Search "down"; }
                bind "H" { Search "up"; }
            }
        }
      '';
    };

    programs.fish.functions.zj = {
      description = "Attach to (or create) a zellij session named after a project dir";
      body = ''
        if set -q ZELLIJ
          echo "already inside zellij session $ZELLIJ_SESSION_NAME"
          return 1
        end
        set -l name $argv[1]
        test -n "$name"; or set name (basename $PWD)
        zellij attach --create $name
      '';
    };

    # resurrectable sessions live here
    home.persistence."/persist/".directories = [ ".cache/zellij" ];
  };
}
