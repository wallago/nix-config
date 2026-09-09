{ self, ... }:
{
  flake.homeModules.niriBinds =
    { pkgs, lib, ... }:
    {
      programs.niri.settings.binds = lib.listToAttrs (
        map (b: {
          name = lib.concatStringsSep "+" (b.mods ++ [ b.key ]);
          value = {
            inherit (b) action;
            hotkey-overlay.title = b.title;
          };
        }) (lib.filter (b: b.action != null) (self.lib.niri.keybinds { inherit pkgs lib; }))
      );
    };
}
