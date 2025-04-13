{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  commonDeps = with pkgs; [
    coreutils
    gnugrep
    systemd
  ];
  mkScript =
    {
      name ? "script",
      deps ? [ ],
      script ? "",
    }:
    lib.getExe (
      pkgs.writeShellApplication {
        inherit name;
        text = script;
        runtimeInputs = commonDeps ++ deps;
      }
    );
  mkScriptJson =
    {
      name ? "script",
      deps ? [ ],
      script ? "",
      text ? "",
      tooltip ? "",
      alt ? "",
      class ? "",
      percentage ? "",
    }:
    mkScript {
      inherit name;
      deps = [ pkgs.jq ] ++ deps;
      script = ''
        ${script}
        jq -cn \
          --arg text "${text}" \
          --arg tooltip "${tooltip}" \
          --arg alt "${alt}" \
          --arg class "${class}" \
          --arg percentage "${percentage}" \
          '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
      '';
    };
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    style = import ./style.nix { inherit lib config inputs; };
    systemd.enable = true;
    settings = {
      primary = {
        # layer = "top";
        # position = "top";
        # output = [
        #   "Primary"
        # ];
        # height = 30;
        # margin-top = 5;
        # margin-bottom = 0;
        # margin-left = 5;
        # margin-right = 5;
        exclusive = false;
        passthrough = false;
        height = 40;
        margin = "6";
        position = "top";

        modules-left =
          [ "custom/menu" ]
          ++ (lib.optionals hyprlandCfg.enable [
            "hyprland/workspaces"
            "hyprland/submap"
          ])
          ++ [
            "custom/currentplayer"
            "custom/player"
            "custom/minicava"
          ];
        modules-center = [
          "cpu"
          "custom/gpu"
          "memory"
          "clock"
          "custom/unread-mail"
        ];
        modules-right = [
          "tray"
          "custom/rfkill"
          "network"
          "custom/rx-net"
          "custom/tx-net"
          "pulseaudio"
          "battery"
          "custom/hostname"
        ];

        clock = import ./modules/clock.nix;
        cpu = import ./modules/cpu.nix;
        "custom/gpu" = import ./modules/gpu.nix { inherit mkScript; };
        memory = import ./modules/memory.nix;
        pulseaudio = import ./modules/pulseaudio.nix { inherit pkgs lib; };
        battery = import ./modules/battery.nix;
        network = import ./modules/network.nix;
        "custom/menu" = import ./modules/menu.nix { inherit hyprlandCfg lib mkScriptJson; };
        "custom/hostname" = import ./modules/hostname.nix { inherit mkScript; };
        "custom/unread-mail" = import ./modules/unread-mail.nix { inherit pkgs mkScriptJson; };
        "custom/rfkill" = import ./modules/rfkill.nix { inherit pkgs mkScript; };
        "custom/player" = import ./modules/player.nix { inherit pkgs mkScript; };
        "custom/currentplayer" = import ./modules/currentplayer.nix { inherit pkgs mkScriptJson; };
        "custom/minicava" = import ./modules/minicava.nix { inherit pkgs lib mkScript; };
        "custom/tx-net" = {
          format = "{icon} {}";
          format-icons = {
            default = "";
          };
          return-type = "json";
          tooltip = false;
          interval = 1;
          exec = "${pkgs.writeShellScript "net-tx" ''
            INTERFACE=$(ip route get 1.1.1.1 | grep -oP 'dev\s+\K[^ ]+')
            NET_TX1=$(ifstat -j | jq ".kernel.$INTERFACE.tx_bytes")
            sleep 1
            NET_TX2=$(ifstat -j | jq ".kernel.$INTERFACE.tx_bytes")
            NET_TX=$((NET_TX2 - NET_TX1))
            if [ $NET_TX -ge 1073741824 ]; then
              RATE=$(echo "scale=2; $NET_TX / 1073741824" | bc)
              UNIT="GB/s"
            elif [ $NET_TX -ge 1048576 ]; then
              RATE=$(echo "scale=2; $NET_TX / 1048576" | bc)
              UNIT="MB/s"
            elif [ $NET_TX -ge 1024 ]; then
              RATE=$(echo "scale=2; $NET_TX / 1024" | bc)
              UNIT="KB/s"
            else
              RATE=$NET_TX
              UNIT="B/s"
            fi
            echo "{\"text\": \"$RATE $UNIT\"}"
          ''}";
          exec-if = "${pkgs.writeShellScript "check-interface" ''
            INTERFACE_COUNT=$(ip route get 1.1.1.1 | grep -oP 'dev\s+\K[^ ]+' | wc -l)
            if [[ $INTERFACE_COUNT -gt 0 ]]; then
              exit 0
            else
              exit 1
            fi
          ''}";
        };
        "custom/rx-net" = {
          format = "{icon} {}";
          format-icons = {
            default = "";
          };
          return-type = "json";
          tooltip = false;
          interval = 1;
          exec = "${pkgs.writeShellScript "net-rx" ''
            INTERFACE=$(ip route get 1.1.1.1 | grep -oP 'dev\s+\K[^ ]+')
            NET_RX1=$(ifstat -j | jq ".kernel.$INTERFACE.rx_bytes")
            sleep 1
            NET_RX2=$(ifstat -j | jq ".kernel.$INTERFACE.rx_bytes")
            NET_RX=$((NET_RX2 - NET_RX1))
            if [ $NET_RX -ge 1073741824 ]; then
              RATE=$(echo "scale=2; $NET_RX / 1073741824" | bc)
              UNIT="GB/s"
            elif [ $NET_RX -ge 1048576 ]; then
              RATE=$(echo "scale=2; $NET_RX / 1048576" | bc)
              UNIT="MB/s"
            elif [ $NET_RX -ge 1024 ]; then
              RATE=$(echo "scale=2; $NET_RX / 1024" | bc)
              UNIT="KB/s"
            else
              RATE=$NET_RX
              UNIT="B/s"
            fi
            echo "{\"text\": \"$RATE $UNIT\"}"
          ''}";
          exec-if = "${pkgs.writeShellScript "check-interface" ''
            INTERFACE_COUNT=$(ip route get 1.1.1.1 | grep -oP 'dev\s+\K[^ ]+' | wc -l)
            if [[ $INTERFACE_COUNT -gt 0 ]]; then
              exit 0
            else
              exit 1
            fi
          ''}";
        };

      };
    };
  };
}
