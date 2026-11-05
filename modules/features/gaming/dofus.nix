# Setup: download the Linux Ankama Launcher AppImage:
#   mkdir -p ~/.local/share/ankama
#   curl -fL -o ~/.local/share/ankama/Ankama-Launcher.AppImage "https://launcher.cdn.ankama.com/installers/production/Ankama%20Launcher-Setup-x86_64.AppImage"
#   chmod +x ~/.local/share/ankama/Ankama-Launcher.AppImage
# Play: Ctrl+Alt+F3, log in, `dofus-x` (Ctrl+Alt+F1 back to niri).
# Leave: quit the launcher, or Ctrl+Alt+Backspace, or `pkill Xorg` from a TTY.
# Why Xorg: the Linux client can't read monitors under niri/xwayland-satellite.
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

      services.xserver = {
        enable = true;
        displayManager.startx.enable = true;
        xkb.options = "terminate:ctrl_alt_bksp";
      };
    };

  flake.homeModules.dofus =
    { pkgs, ... }:
    let
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

      dofus-x = pkgs.writeShellApplication {
        name = "dofus-x";
        text = ''
          xinitrc="$(mktemp)"
          printf '%s\n' '#!/bin/sh' \
            '${pkgs.openbox}/bin/openbox &' \
            'export SDL_VIDEODRIVER=x11' \
            'exec ${dofus}/bin/dofus' >"$xinitrc"
          chmod +x "$xinitrc"
          exec startx "$xinitrc" -- vt"''${XDG_VTNR:-3}"
        '';
      };
    in
    {
      home.packages = [
        dofus
        dofus-x
      ];
    };
}
