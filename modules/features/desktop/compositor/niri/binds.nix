{ self, ... }:
{
  flake.homeModules.niriBinds =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      binds = lib.filter (b: b.action != null) (self.lib.niri.keybinds { inherit pkgs lib; });

      bind = mods: key: action: title: {
        name = lib.concatStringsSep "+" (mods ++ [ key ]);
        value = {
          inherit action;
          hotkey-overlay.title = title;
        };
      };

      kaguBinds = map (b: bind b.kagu.mods b.kagu.key (b.kagu.action or b.action) b.title) (
        lib.filter (b: b ? kagu) binds
      );
    in
    {
      programs.niri.settings.binds = lib.listToAttrs (
        map (b: bind b.mods b.key b.action b.title) binds
        ++ lib.optionals config.preferences.user.keyboard.kagu.enable kaguBinds
      );
    };
}
