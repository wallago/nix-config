{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      primary = {
        layer = "top";
        position = "top";
        output = [
          "Primary"
        ];
        height = 30;
        margin-top = 5;
        margin-bottom = 0;
        margin-left = 5;
        margin-right = 5;
        modules-left = [
          "clock#date"
          "clock#time"
          "network"
        ];
        modules-right = [
          "battery"
          "backlight"
          "pulseaudio"
          "cpu"
          "memory"
          "temperature"
          "disk"
        ];
        "cpu" = {
          format = "  {usage}%";
          interval = 1;
          tooltip = false;
        };
        "memory" = {
          format = "󰒋  {used:0.1f}Go / {total:0.1f}Go";
          interval = 1;
          tooltip = false;
        };
        "temperature" = {
          format = "{icon} {temperatureC}°C";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          interval = 1;
          tooltip = false;
        };
        "disk" = {
          format = "󰟀  {used} / {free}";
          interval = 1;
          tooltip = false;
        };
        "network" = {
          format-disconnected = "{icon} disconnected";
          format-wifi = "{icon} {essid} ({signalStrength}%) 󰑹 {ifname}";
          format-ethernet = "{icon} {ifname}: {ipaddr}/{cidr}";
          format-icons = {
            ethernet = " ";
            disconnected = " ";
            wifi = " ";
          };
          interval = 1;
          tooltip = false;
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon}  {volume}% {desc}";
          format-muted = "";
          format-icons = {
            headphones = " ";
            handsfree = " ";
            headset = " ";
            phone = " ";
            phone-muted = " ";
            portable = " ";
            car = " ";
            default = [
              " "
              " "
            ];
          };
          scroll-step = 1;
          tooltip = false;
        };
        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          interval = 1;
          tooltip = false;
        };
        "battery" = {
          format = "{capacity}% {icon} ({time})";
          format-time = "{H}:{M:02}";
          format-charging = "{icon} {capacity}% ({time})";
          format-charging-full = "{icon} {capacity}%";
          format-full = "{icon} {capacity}%";
          format-icons = {
            charging = " ";
            charging-full = " ";
            default = [
              " "
              " "
              " "
              " "
              " "
            ];
          };
          tooltip = false;
          interval = 1;
        };
        "clock#time" = {
          timezone = "Europe/Paris";
          interval = 10;
          format = "{:%H:%M}";
          tooltip = false;
        };
        "clock#date" = {
          format = " {:%e %b %Y}";
          timezone = "Europe/Paris";
          interval = 240;
          tooltip = false;
        };
      };
    };
  };
}
