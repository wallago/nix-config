{
  flake.homeModules.niriSlots =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      slots = lib.filter (e: e.key != null) config.preferences.session;
      launcher = e: pkgs.writeShellScript "slot-${e.key}" "exec ${lib.escapeShellArgs e.command}";
      table = pkgs.writeText "niri-slots.json" (
        builtins.toJSON (
          map (e: {
            inherit (e) key;
            app_id = e.matchAppId;
            title = e.matchTitle;
            spawn = "${launcher e}";
            inherit (e) floating;
          }) slots
        )
      );

      dispatcher = pkgs.writeShellScript "niri-slot" ''
        set -eu
        key=$1
        table=${table}

        wins=$(niri msg -j windows)
        wss=$(niri msg -j workspaces)
        cur_id=$(printf '%s' "$wss" | ${lib.getExe pkgs.jq} -r 'map(select(.is_focused))[0].id')
        cur_out=$(printf '%s' "$wss" | ${lib.getExe pkgs.jq} -r 'map(select(.is_focused))[0].output')

        slot_win() {
          ${lib.getExe pkgs.jq} -r --argjson w "$wins" --arg k "$1" '
            (map(select(.key == $k))[0]) as $s
            | ($w | map(select(
                .app_id == $s.app_id
                and ($s.title == null or ((.title // "") | test($s.title)))
              ))[0]) as $m
            | if $m == null then empty else "\($m.id) \($m.workspace_id)" end
          ' "$table"
        }

        found=$(slot_win "$key")
        if [ -z "$found" ]; then
          exec "$(${lib.getExe pkgs.jq} -r --arg k "$key" \
            'map(select(.key == $k))[0].spawn' "$table")"
        fi

        id=$(printf '%s' "$found" | cut -d' ' -f1)
        ws=$(printf '%s' "$found" | cut -d' ' -f2)

        if [ "$ws" = "$cur_id" ]; then
          niri msg action move-window-to-workspace --window-id "$id" --focus false scratch
          exit 0
        fi

        for other in $(${lib.getExe pkgs.jq} -r --arg k "$key" \
          'map(select(.key != $k)) | .[].key' "$table"); do
          hit=$(slot_win "$other")
          [ -n "$hit" ] || continue
          oid=$(printf '%s' "$hit" | cut -d' ' -f1)
          niri msg action move-window-to-workspace --window-id "$oid" --focus false scratch
        done

        niri msg action move-window-to-monitor --id "$id" "$cur_out"

        if [ "$(${lib.getExe pkgs.jq} -r --arg k "$key" \
          'map(select(.key == $k))[0].floating' "$table")" = "true" ]; then
          niri msg action move-window-to-floating --id "$id"
        fi

        niri msg action focus-window --id "$id"
      '';
    in
    {
      programs.niri.settings.binds = lib.listToAttrs (
        map (
          e:
          lib.nameValuePair "Mod+${e.key}" {
            action.spawn = [
              "${dispatcher}"
              e.key
            ];
            hotkey-overlay.title = lib.removePrefix "com.slot." e.matchAppId;
          }
        ) slots
      );
    };
}
