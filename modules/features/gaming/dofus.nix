# Setup: download the Linux Ankama Launcher AppImage:
#   mkdir -p ~/.local/share/ankama
#   curl -fL -o ~/.local/share/ankama/Ankama-Launcher.AppImage "https://launcher.cdn.ankama.com/installers/production/Ankama%20Launcher-Setup-x86_64.AppImage"
#   chmod +x ~/.local/share/ankama/Ankama-Launcher.AppImage
# Play: launch "Dofus" from the app launcher, or run `dofus-niri`.
# Leave: quit the launcher, or close the window.
# Why a nested X server: the Linux client finds its window through
# _NET_CLIENT_LIST, which xwayland-satellite doesn't publish. openbox does.
{
  flake.nixosModules.dofus =
    { pkgs, ... }:
    {
      programs.appimage = {
        enable = true;
        package = pkgs.appimage-run.override {
          extraPkgs = p: [
            p.icu # .NET/Unity globalization
            p.libsecret # launcher stores its login (API key) via keytar
          ];
        };
      };
    };

  flake.homeModules.dofus =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      # The monitor Dofus opens on: preferences.dofus.output, or the only one.
      output =
        let
          names = lib.attrNames config.preferences.monitors;
        in
        if config.preferences.dofus.output != null then
          config.preferences.dofus.output
        else if lib.length names == 1 then
          lib.head names
        else
          throw "preferences.dofus.output: this host has ${toString (lib.length names)} monitors, name the one Dofus opens on";
      inherit (config.preferences.monitors.${output}) mode;

      dofus = pkgs.writeShellApplication {
        name = "dofus";
        runtimeInputs = [ pkgs.xdg-utils ];
        text = ''
          dir="''${XDG_DATA_HOME:-$HOME/.local/share}/ankama"
          appimage="$dir/Ankama-Launcher.AppImage"

          if [ ! -x "$appimage" ]; then
            mkdir -p "$dir"
            printf '%s\n' \
              "[dofus] Ankama Launcher not found. Download the Linux AppImage and save it as:" \
              "  $appimage" \
              "then run: chmod +x \"$appimage\" && dofus" >&2
            xdg-open "https://www.ankama.com/en/launcher" >/dev/null 2>&1 || true
            exit 1
          fi

          # appimage-run comes from programs.appimage (system), so extraPkgs apply
          exec appimage-run "$appimage" "$@"
        '';
      };

      # Side mouse buttons hold keys, only inside the nested X server:
      # 8 is the back button, 9 the forward one.
      dofus-binds = pkgs.writeText "dofus-xbindkeysrc" ''
        "xdotool keydown y"
          b:8
        "xdotool keyup y"
          b:8 + Release
        "xdotool keydown w"
          b:9
        "xdotool keyup w"
          b:9 + Release
      '';

      # Rootful Xwayland: one fullscreen niri window holding a whole X screen.
      # -geometry is the monitor's pixel size: -fullscreen alone keeps a
      # 640x480 screen and stretches it, and -hidpi crashes Xwayland when the
      # window opens on a scaled output.
      # -noreset keeps the server up when its last client disconnects.
      # WAYLAND_DISPLAY is unset so the client only uses its X11 code path.
      dofus-niri = pkgs.writeShellApplication {
        name = "dofus-niri";
        runtimeInputs = [
          pkgs.xwayland
          pkgs.openbox
          pkgs.xbindkeys
          pkgs.xdotool
        ];
        text = ''
          run="$(mktemp -d)"
          xw=""
          trap 'kill "$xw" 2>/dev/null || true; rm -rf "$run"' EXIT

          # Xwayland picks a free display and writes its number once ready
          Xwayland -displayfd 3 -noreset -fullscreen \
            -geometry ${toString mode.width}x${toString mode.height} 3>"$run/display" &
          xw=$!
          until [ -s "$run/display" ]; do
            if ! kill -0 "$xw" 2>/dev/null; then
              echo "[dofus] Xwayland failed to start" >&2
              exit 1
            fi
            sleep 0.1
          done
          DISPLAY=":$(cat "$run/display")"
          export DISPLAY

          openbox &
          xbindkeys -n -f ${dofus-binds} &
          env -u WAYLAND_DISPLAY XDG_SESSION_TYPE=x11 SDL_VIDEODRIVER=x11 \
            ${dofus}/bin/dofus "$@"
        '';
      };
    in
    {
      home.packages = [
        dofus
        dofus-niri
      ];

      xdg.desktopEntries.dofus = {
        name = "Dofus";
        comment = "Ankama Launcher in a nested X session";
        exec = "${dofus-niri}/bin/dofus-niri";
        categories = [ "Game" ];
      };

      programs.niri.settings.window-rules = [
        {
          matches = [ { app-id = "^org\\.freedesktop\\.Xwayland$"; } ];
          open-on-output = output;
          open-fullscreen = true;
        }
      ];
    };
}
