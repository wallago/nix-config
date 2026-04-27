{
  pkgs,
  lib,
  config,
  ...
}:
let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs =
      pkgs: with pkgs; [
        libXcursor
        libXi
        libXinerama
        libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        gamescope
      ];
  };

  monitor = lib.head (lib.filter (m: m.primary) config.monitors);
  steam-gamescope =
    let
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
      steam = lib.getExe pkgs.steam;

    in
    pkgs.writeTextDir "share/applications/steam-gamescop.desktop" ''
      [Desktop Entry]
      Name=Steam (Gamescope)
      Exec=${gamescope} -- ${steam}
      Type=Application
      Categories=Game;
    '';
in
{
  home.packages = [
    steam-with-pkgs
    steam-gamescope
    pkgs.gamescope
    pkgs.protontricks
  ];

  home.persistence = {
    "/persist/" = {
      directories = [ ".local/share/Steam/" ];
    };
  };
}
