{
  flake.homeModules.zenShortcuts =
    {
      config,
      lib,
      pkgs,
      ...
    }:
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
        # {
        #   id = "goForwardKb";
        #   key = "o";
        #   modifiers.alt = true;
        # }
        # {
        #   id = "goBackKb";
        #   key = "n";
        #   modifiers.alt = true;
        # }
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
      commonConfig = {
        keyboardShortcuts = commonShortcuts;
        keyboardShortcutsVersion = 20;
      };

      extraShortcuts = [
        {
          id = "zen-next-tab";
          key = "o";
          keycode = null;
          group = "other";
          l10nId = "zen-action-next-tab";
          action = "Browser:NextTab";
          modifiers = {
            control = false;
            alt = false;
            shift = true;
            meta = false;
            accel = true;
          };
          disabled = false;
          reserved = false;
          internal = false;
        }
        {
          id = "zen-prev-tab";
          key = "n";
          keycode = null;
          group = "other";
          l10nId = "zen-action-previous-tab";
          action = "Browser:PrevTab";
          modifiers = {
            control = false;
            alt = false;
            shift = true;
            meta = false;
            accel = true;
          };
          disabled = false;
          reserved = false;
          internal = false;
        }
      ];

      zenCfg = config.programs.zen-browser;

      mkExtraFragment = profileName: [
        {
          priority = 110;
          text = toString (
            pkgs.writeShellScript "zen-extra-shortcuts-${profileName}" ''
              SHORTCUTS_FILE="${zenCfg.profilesPath}/${
                zenCfg.profiles.${profileName}.path
              }/zen-keyboard-shortcuts.json"
              EXTRA='${builtins.toJSON extraShortcuts}'

              if [ ! -f "$SHORTCUTS_FILE" ]; then
                echo "zen-extra-shortcuts: $SHORTCUTS_FILE not created yet; Zen writes it on first run"
                exit 0
              fi

              MERGED=$(${lib.getExe pkgs.jq} --argjson extra "$EXTRA" '
                ($extra | map(.id)) as $ids
                | .shortcuts = (
                    (.shortcuts | map(select(.id as $i | $ids | index($i) | not))) + $extra
                  )
              ' "$SHORTCUTS_FILE")

              printf '%s\n' "$MERGED" > "$SHORTCUTS_FILE"
            ''
          );
        }
      ];
    in
    {
      programs.zen-browser = {
        profiles = {
          default = commonConfig;
          secondary = commonConfig;
        };
        activationFragments = {
          default = mkExtraFragment "default";
          secondary = mkExtraFragment "secondary";
        };
      };
    };
}
