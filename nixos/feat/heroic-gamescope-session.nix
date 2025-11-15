{ pkgs, lib, ... }:
let
  heroic-gamescope = pkgs.writeShellScriptBin "heroic-gamescope" ''
    systemctl --user start heroic-gamescope-session.target
    ${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-volume @DEFAULT_SINK@ 50%
    gamescope --heroic -- heroic -tenfoot &>/dev/null
    systemctl --user stop heroic-gamescope-session.target
  '';

  heroic-gamescope-session =
    (pkgs.writeTextDir "share/wayland-sessions/heroic.desktop" ''
      [Desktop Entry]
      Name=Heroic
      Comment=A digital distribution platform
      Exec=${lib.getExe heroic-gamescope}
      Type=Application
    '').overrideAttrs (_: { passthru.providedSessions = [ "heroic" ]; });
in {
  programs.gamescope.enable = true;

  services.displayManager.sessionPackages = [ heroic-gamescope-session ];

  systemd.user.targets.heroic-gamescope-session = {
    description = "Heroic (gamescope) session";
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  systemd.user.services.heroic-gamescope-reaper = {
    description = "Monitor and handle heroic gamescope session exit requests";
    wantedBy = [ "heroic-gamescope-session.target" ];
    partOf = [ "heroic-gamescope-session.target" ];
    after = [ "heroic-gamescope-session.target" ];

    script = ''
      while sleep 5; do
        if tail -n 10 ~/.heroic/heroic/logs/console-linux.txt | grep "The name org.freedesktop.DisplayManager was not provided by any .service files$" -q; then
          echo "Exit request detected, sending shutdown signal"
          ${pkgs.heroic}/bin/heroic -shutdown
        fi
      done
    '';
  };
}
