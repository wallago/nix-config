{
  flake.homeModules.zenShortcuts =
    let
      workspaces = [
        {
          id = "zen-close-all-unpinned-tabs";
          key = "c";
          modifiers.alt = true;
        }
        {
          id = "zen-workspace-forward";
          key = "o";
          modifiers.control = true;
        }
        {
          id = "zen-workspace-backward";
          key = "n";
          modifiers.control = true;
        }
      ];
      compact = [
        {
          id = "zen-compact-mode-toggle";
          key = "c";
          modifiers = {
            control = true;
            alt = true;
          };
        }
        {
          id = "zen-toggle-sidebar";
          key = "x";
          modifiers = {
            control = true;
            alt = true;
          };
        }
      ];
      find = [
        {
          id = "key_findAgain";
          key = "r";
          modifiers = {
            control = true;
            shift = true;
          };
        }
        {
          id = "key_findNext";
          key = "r";
          modifiers.control = true;
        }
      ];
      tabs = [
        {
          id = "key_close";
          key = "q";
          modifiers.alt = true;
        }
        {
          id = "key_newNavigator";
          disabled = true;
        }
        {
          id = "key_quitApplication";
          disabled = true;
        }
      ];
      nav = [
        {
          id = "goForwardKb";
          key = "o";
          modifiers.alt = true;
        }
        {
          id = "goBackwardKb";
          key = "n";
          modifiers.alt = true;
        }
        {
          id = "key_reload";
          key = "r";
          modifiers.control = true;
        }
        {
          id = "key_reload_skip_cache";
          key = "r";
          modifiers = {
            control = true;
            shift = true;
          };
        }
      ];
      misc = [
        {
          id = "zen-copy-url-markdown";
          key = "m";
          modifiers.control = true;
        }
      ];
      commonShortcuts = workspaces ++ tabs ++ nav ++ compact ++ find ++ misc;
    in
    {
      programs.zen-browser.profiles.default = {
        keyboardShortcuts = commonShortcuts;
        keyboardShortcutsVersion = 19;
      };
      programs.zen-browser.profiles.perso = {
        keyboardShortcuts = commonShortcuts;
        keyboardShortcutsVersion = 19;
      };
      programs.zen-browser.profiles.work = {
        keyboardShortcuts = commonShortcuts;
        keyboardShortcutsVersion = 19;
      };
    };
}
