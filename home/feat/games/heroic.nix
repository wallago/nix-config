{ pkgs, lib, config, ... }:
let
  monitor = lib.head (lib.filter (m: m.primary) config.monitors);
  heroic-gamescope = let
    gamescope = lib.concatStringsSep " " [
      (lib.getExe pkgs.gamescope)
      "--output-width ${toString monitor.width}"
      "--output-height ${toString monitor.height}"
      "--framerate-limit ${toString monitor.refreshRate}"
      "--prefer-output ${monitor.name}"
      "--adaptive-sync"
      "--expose-wayland"
      "--hdr-enabled"
    ];
    heroic = lib.getExe pkgs.heroic;
  in pkgs.writeTextDir "share/applications/heroic-gamescop.desktop" ''
    [Desktop Entry]
    Name=Heroic (Gamescope)
    Exec=${gamescope} -- ${heroic}
    Type=Application
    Categories=Game;
  '';
in {
  home.packages =
    [ pkgs.heroic heroic-gamescope pkgs.gamescope pkgs.protontricks ];

  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      allowOther = true;
      directories = [ ".local/share/Steam/" ];
    };
  };
}
