{
  flake.nixosModules.dofus =
    { pkgs, ... }:
    {
      programs.appimage = {
        enable = true;
        binfmt = true;
        package = pkgs.appimage-run.override {
          extraPkgs = p: [
            p.icu # .NET/Unity globalization, avoids the generic .NET crash
            p.libsecret # launcher stores its login (API key) via keytar
          ];
        };
      };

      # Xorg for Dofus, started from a TTY with `dofus-x` (SDDM's Wayland
      # greeter can't launch X sessions). The native client can't read
      # monitors under niri/xwayland-satellite.
      services.xserver = {
        enable = true;
        displayManager.startx.enable = true;
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

      # Browser login hands back to the launcher via ankama:// links
      xdg.desktopEntries.ankama-launcher = {
        name = "Ankama Launcher";
        exec = "dofus %u";
        icon = "applications-games";
        categories = [ "Game" ];
        mimeType = [
          "x-scheme-handler/ankama"
          "x-scheme-handler/ankama-launcher"
        ];
      };
    };
}
