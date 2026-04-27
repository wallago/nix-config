{ pkgs, mkScriptJson, ... }: {
  interval = 2;
  return-type = "json";
  exec = mkScriptJson {
    deps = [ pkgs.playerctl ];
    script = ''
      all_players=$(playerctl -l 2>/dev/null)
      selected_player="$(playerctl status -f "{{playerName}}" 2>/dev/null || true)"
      clean_player="$(echo "$selected_player" | cut -d '.' -f1)"
    '';
    alt = "$clean_player";
    tooltip = "$all_players";
  };
  format = "{icon}{}";
  format-icons = {
    "" = " ";
    "Celluloid" = "󰎁 ";
    "spotify" = "󰓇 ";
    "ncspot" = "󰓇 ";
    "qutebrowser" = "󰖟 ";
    "firefox" = " ";
    "discord" = " 󰙯 ";
    "sublimemusic" = " ";
    "kdeconnect" = "󰄡 ";
    "chromium" = " ";
  };
}
