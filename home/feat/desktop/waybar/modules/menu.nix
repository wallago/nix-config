{
  hyprlandCfg,
  lib,
  mkScriptJson,
  ...
}:
{
  interval = 1;
  return-type = "json";
  exec = mkScriptJson {
    deps = lib.optional hyprlandCfg.enable hyprlandCfg.package;
    text = "";
    tooltip = ''$(grep PRETTY_NAME /etc/os-release | cut -d '"' -f2)'';
    class =
      let
        isFullScreen =
          if hyprlandCfg.enable then "hyprctl activewindow -j | jq -e '.fullscreen' &>/dev/null" else "false";
      in
      "$(if ${isFullScreen}; then echo fullscreen; fi)";
  };
}
