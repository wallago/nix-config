{ pkgs, mkScriptJson, ... }:
{
  interval = 5;
  return-type = "json";
  exec = mkScriptJson {
    deps = [
      pkgs.findutils
      pkgs.procps
    ];
    script = ''
      count=$(find ~/Mail/*/Inbox/new -type f | wc -l)
      if pgrep mbsync &>/dev/null; then
        status="syncing"
      else
        if [ "$count" == "0" ]; then
          status="read"
        else
          status="unread"
        fi
      fi
    '';
    text = "$count";
    alt = "$status";
  };
  format = "{icon}  ({})";
  format-icons = {
    "read" = "󰇯";
    "unread" = "󰇮";
    "syncing" = "󰁪";
  };
}
