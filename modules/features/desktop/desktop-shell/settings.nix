{
  # Shared Dux Shell settings, the same on every host. DMS lays
  # ~/.config/dms/config.d/*.json over settings.json one top-level key at a
  # time. This file is a read-only store link, so its keys can't drift from the
  # GUI; every other key stays editable and still saves to settings.json.
  flake.homeModules.desktopShell =
    { lib, pkgs, ... }:
    {
      xdg.configFile."dms/config.d/10-nix.json".source =
        (pkgs.formats.json { }).generate "dms-settings.json"
          (lib.importJSON ./settings.json);
    };
}
