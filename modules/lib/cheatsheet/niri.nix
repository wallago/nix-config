{ self, ... }:
{
  flake.lib.cheatsheets.niri =
    { pkgs, lib }:
    let
      cards = [
        {
          id = "navigation";
          label = "Navigation";
          subtitle = "Move focus and shuffle columns";
          accent = "#4a9eff";
          icon = 61618;
        }
        {
          id = "monitors";
          label = "Monitors";
          subtitle = "Move between and across screens";
          accent = "#06b6d4";
          icon = 61704;
        }
        {
          id = "windows";
          label = "Windows";
          subtitle = "Size, float and arrange windows";
          accent = "#a855f7";
          icon = 62162;
        }
        {
          id = "workspaces";
          label = "Workspaces";
          subtitle = "Move up and down workspaces";
          accent = "#22c55e";
          icon = 61449;
        }
        {
          id = "apps";
          label = "Apps";
          subtitle = "Launch and lock";
          accent = "#f59e0b";
          icon = 61728;
        }
        {
          id = "system";
          label = "System";
          subtitle = "Session and global actions";
          accent = "#f43f5e";
          icon = 61459;
        }
      ];

      keyNames = {
        BracketLeft = "[";
        BracketRight = "]";
        Escape = "ESC";
        Return = "RETURN";
        Slash = "?";
        Space = "SPACE";
        Tab = "TAB";
      };

      modNames = {
        Mod = "Super";
        Shift = "Shift";
        Ctrl = "Ctrl";
        Alt = "Alt";
      };

      binds = self.lib.niri.keybinds { inherit pkgs lib; };

      usedMods = lib.unique (lib.concatMap (b: b.mods) binds);

      ids = map (c: c.id) cards;
      unknown = lib.unique (map (b: b.category) (lib.filter (b: !(lib.elem b.category ids)) binds));
    in
    {
      order = 0;

      title = "Niri";
      subtitle = "Keyboard Shortcuts";
      footer = "The window manager for people who like to be in control.";

      legend = map (m: {
        key = lib.toUpper m;
        label = modNames.${m};
      }) usedMods;

      cards =
        lib.throwIf (unknown != [ ])
          "cheatsheet/niri: binds tagged with unknown categories: ${lib.concatStringsSep ", " unknown}"
          (
            map (
              c:
              (removeAttrs c [ "id" ])
              // {
                rows = map (b: {
                  inherit (b) mods title;
                  key = keyNames.${b.key} or b.key;
                }) (lib.filter (b: b.category == c.id) binds);
              }
            ) cards
          );
    };
}
