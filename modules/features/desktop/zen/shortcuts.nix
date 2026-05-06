{
  flake.homeModules.zenShortcuts = {
    programs.zen-browser.profiles.default = {
      keyboardShortcuts = [
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
        {
          id = "key_quitApplication";
          disabled = true;
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
      # In order to avoid breaking changes here, sometimes when you upgrade you
      # should be asked to bump this version
      keyboardShortcutsVersion = 17;
    };
  };
}
