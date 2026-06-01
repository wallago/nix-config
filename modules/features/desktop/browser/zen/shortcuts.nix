{
  flake.homeModules.zenShortcuts = {
    programs.zen-browser.profiles.default = {
      keyboardShortcuts = [
        # Compact Mode
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
        # Workspaces
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

        # Other Zen Features
        {
          id = "zen-copy-url-markdown";
          key = "m";
          modifiers.control = true;
        }

        # Window & Tab Management
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

        # Navigation
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

        # Search & Find
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
      # In order to avoid breaking changes here, sometimes when you upgrade you
      # should be asked to bump this version
      keyboardShortcutsVersion = 19;
    };
  };
}
