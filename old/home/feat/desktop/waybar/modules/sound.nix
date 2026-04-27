{ pkgs, lib, ... }: {
  format-source = "󰍬 {volume}%";
  format-source-muted = "󰍭 0%";
  format = "{icon} {volume}%   {format_source}";
  format-muted = "󰸈 0% {format_source}";
  format-icons = { default = [ "󰕿" "󰖀" "󰕾" ]; };
  on-click = "${lib.getExe pkgs.pavucontrol}";
}
