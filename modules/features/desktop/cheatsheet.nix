{ self, ... }:
{
  flake.homeModules.cheatsheet =
    { pkgs, lib, ... }:
    let
      sheets = lib.sort (a: b: a.order < b.order) (
        lib.mapAttrsToList (name: mk: (mk { inherit pkgs lib; }) // { inherit name; }) self.lib.cheatsheets
      );

      total = lib.length sheets;

      render =
        i: s:
        let
          json = (pkgs.formats.json { }).generate "cheatsheet-${s.name}.json" {
            inherit (s) name cards;
            index = i + 1;
            inherit total;
          };
        in
        pkgs.runCommand "cheatsheet-${s.name}.png"
          {
            nativeBuildInputs = [ pkgs.typst ];
          }
          ''
            cp ${./cheatsheet.typ} sheet.typ
            cp ${json} sheet.json
            typst compile \
              --font-path ${pkgs.nerd-fonts.fira-code}/share/fonts \
              --font-path ${pkgs.noto-fonts}/share/fonts \
              --format png \
              --ppi 144 \
              sheet.typ "$out"
          '';

      pages = pkgs.runCommand "cheatsheets" { } (
        ''
          mkdir -p "$out"
        ''
        + lib.concatStrings (
          lib.imap0 (i: s: ''
            ln -s ${render i s} "$out/${lib.fixedWidthString 2 "0" (toString i)}-${s.name}.png"
          '') sheets
        )
      );

      viewer = pkgs.writeShellApplication {
        name = "cheatsheet";
        runtimeInputs = [ pkgs.swayimg ];
        text = ''
          exec swayimg \
            --appid com.slot.cheatsheet \
            --execute '
              swayimg.decoration = false
              swayimg.text.visible = false
              swayimg.viewer.on_key("left", function() swayimg.viewer.open("prev") end)
              swayimg.viewer.on_key("right", function() swayimg.viewer.open("next") end)
            ' \
            ${pages}
        '';
      };
    in
    {
      home.packages = [ viewer ];

      preferences.session = [
        {
          command = [ "cheatsheet" ];
          matchAppId = "com.slot.cheatsheet";
          key = "Shift+Slash";
          floating = true;
        }
      ];
    };
}
