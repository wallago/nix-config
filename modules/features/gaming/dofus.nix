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
    };

  flake.homeModules.dofus =
    { pkgs, ... }:
    let
      dofus = pkgs.writeShellApplication {
        name = "dofus";
        runtimeInputs = [ pkgs.curl ];
        text = ''
          dir="''${XDG_DATA_HOME:-$HOME/.local/share}/ankama"
          appimage="$dir/Ankama-Launcher.AppImage"
          url="''${DOFUS_APPIMAGE_URL:-https://download.ankama.com/launcher/full/linux}"

          if [ ! -x "$appimage" ]; then
            mkdir -p "$dir"
            echo "[dofus] downloading Ankama Launcher from $url" >&2
            curl --fail --location --retry 3 --output "$appimage.part" "$url"
            chmod +x "$appimage.part"
            mv "$appimage.part" "$appimage"
          fi

          # appimage-run comes from programs.appimage (system), so extraPkgs apply
          exec appimage-run "$appimage" "$@"
        '';
      };
    in
    {
      home.packages = [ dofus ];

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
