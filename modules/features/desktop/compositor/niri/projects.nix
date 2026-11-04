{
  flake.homeModules.niriProjects =
    { lib, pkgs, ... }:
    let
      jq = lib.getExe pkgs.jq;

      picker = pkgs.writeShellScript "niri-project" ''
        set -eu

        ws=$(niri msg -j workspaces)

        pick=$(printf '%s' "$ws" \
          | ${jq} -r '.[] | select(.name != null and .name != "scratch") | .name' \
          | ${lib.getExe pkgs.fuzzel} --dmenu --prompt 'project> ') || exit 0
        [ -n "$pick" ] || exit 0

        if printf '%s' "$ws" | ${jq} -e --arg n "$pick" 'any(.[]; .name == $n)' >/dev/null; then
          exec niri msg action focus-workspace "$pick"
        fi

        out=$(printf '%s' "$ws" | ${jq} -r 'map(select(.is_focused))[0].output')
        idx=$(printf '%s' "$ws" | ${jq} -r --arg o "$out" '
          map(select(.output == $o and .active_window_id == null and .name == null))
          | max_by(.idx).idx
        ')

        niri msg action focus-workspace "$idx"
        niri msg action set-workspace-name "$pick"
      '';
    in
    {
      programs.niri.settings.binds = {
        "Mod+W" = {
          action.spawn = "${picker}";
          hotkey-overlay.title = "Project Workspace";
        };
        "Mod+Shift+W" = {
          action.unset-workspace-name = [ ];
          hotkey-overlay.title = "Unname Workspace";
        };
      };
    };
}
