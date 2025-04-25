{ pkgs, mkScript, ... }: {
  exec-if = mkScript {
    deps = [ pkgs.playerctl ];
    script = ''
      selected_player="$(playerctl status -f "{{playerName}}" 2>/dev/null || true)"
      playerctl status -p "$selected_player" 2>/dev/null
    '';
  };
  exec = mkScript {
    deps = [ pkgs.playerctl ];
    script = ''
      selected_player="$(playerctl status -f "{{playerName}}" 2>/dev/null || true)"
      playerctl metadata -p "$selected_player" \
        --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{artist}} - {{title}} ({{album}})"}' 2>/dev/null
    '';
  };
  return-type = "json";
  interval = 2;
  max-length = 30;
  format = "{icon} {}";
  format-icons = {
    "Playing" = "󰐊";
    "Paused" = "󰏤 ";
    "Stopped" = "󰓛";
  };
  on-click = mkScript {
    deps = [ pkgs.playerctl ];
    script = "playerctl play-pause";
  };
}
