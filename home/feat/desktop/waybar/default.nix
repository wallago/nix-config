{ pkgs, lib, config, inputs, ... }:
let
  commonDeps = with pkgs; [ coreutils gnugrep systemd ];
  mkScript = { name ? "script", deps ? [ ], script ? "", }:
    lib.getExe (pkgs.writeShellApplication {
      inherit name;
      text = script;
      runtimeInputs = commonDeps ++ deps;
    });
  mkScriptJson = { name ? "script", deps ? [ ], script ? "", text ? ""
    , tooltip ? "", alt ? "", class ? "", percentage ? "", }:
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
in {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    style = import ./style.nix { inherit lib config inputs; };
    systemd.enable = true;
    settings = {
      primary = {
        exclusive = false;
        passthrough = false;
        height = 40;
        margin = "6";
        position = "top";

        modules-left = [ "custom/menu" ] ++ (lib.optionals hyprlandCfg.enable [
          "hyprland/workspaces"
          "hyprland/submap"
        ]) ++ [ "custom/currentplayer" "custom/player" "custom/minicava" ];
        modules-center =
          [ "cpu" "custom/gpu" "memory" "clock" "custom/unread-mail" ];
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
        "custom/menu" =
          import ./modules/menu.nix { inherit hyprlandCfg lib mkScriptJson; };
        "custom/hostname" = import ./modules/hostname.nix { inherit mkScript; };
        "custom/unread-mail" =
          import ./modules/unread-mail.nix { inherit pkgs mkScriptJson; };
        "custom/rfkill" =
          import ./modules/rfkill.nix { inherit pkgs mkScript; };
        "custom/player" =
          import ./modules/player.nix { inherit pkgs mkScript; };
        "custom/currentplayer" =
          import ./modules/currentplayer.nix { inherit pkgs mkScriptJson; };
        "custom/minicava" =
          import ./modules/minicava.nix { inherit pkgs lib mkScript; };
        "custom/tx-net" = import ./modules/tx-net.nix { inherit mkScript; };
        "custom/rx-net" = import ./modules/rx-net.nix { inherit mkScript; };

      };
    };
  };
}
