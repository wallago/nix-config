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
          icon = "\uf0b2";
        }
        {
          id = "monitors";
          label = "Monitors";
          subtitle = "Move between and across screens";
          accent = "#06b6d4";
          icon = "\uf108";
        }
        {
          id = "windows";
          label = "Windows";
          subtitle = "Size, float and arrange windows";
          accent = "#a855f7";
          icon = "\uf2d2";
        }
        {
          id = "workspaces";
          label = "Workspaces";
          subtitle = "Move up and down workspaces";
          accent = "#22c55e";
          icon = "\uf009";
        }
        {
          id = "apps";
          label = "Apps";
          subtitle = "Launch and lock";
          accent = "#f59e0b";
          icon = "\uf120";
        }
        {
          id = "system";
          label = "System";
          subtitle = "Session and global actions";
          accent = "#f43f5e";
          icon = "\uf013";
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

      binds = self.lib.niri.keybinds { inherit pkgs lib; };

      ids = map (c: c.id) cards;
      unknown = lib.unique (map (b: b.category) (lib.filter (b: !(lib.elem b.category ids)) binds));
    in
    {
      order = 0;

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
