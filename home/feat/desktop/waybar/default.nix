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
        exclusive = true;
        passthrough = false;
        height = 40;
        margin-top = 10;
        margin-bottom = 0;
        margin-left = 20;
        margin-right = 20;
        position = "top";

        modules-left = [
          # "custom/os"
          "clock"
        ]
        ++ (lib.optionals hyprlandCfg.enable [
          "hyprland/workspaces"
          "hyprland/submap"
        ])
        ++ [
          # "custom/currentplayer"
          "pulseaudio"
          "custom/player"
          "custom/minicava"
          "custom/unread-mail"
        ];
        modules-center = [
          "cpu"
          # "custom/intel-gpu"
          # "custom/nvidia-gpu"
          "memory"
        ];
        modules-right = [
          "custom/rfkill"
          "network"
          "custom/rx-net"
          "custom/tx-net"
          "battery"
          "custom/gpg-status"
          "custom/hostname"
        ];

        clock = import ./modules/clock.nix;
        cpu = import ./modules/cpu.nix;
        memory = import ./modules/memory.nix;
        pulseaudio = import ./modules/sound.nix { inherit pkgs lib; };
        battery = import ./modules/battery.nix;
        network = import ./modules/network.nix;
        "custom/os" = import ./modules/os.nix { inherit mkScript; };
        "custom/hostname" = import ./modules/hostname.nix { inherit mkScript; };
        "custom/unread-mail" = import ./modules/unread-mail.nix { inherit pkgs mkScriptJson; };
        "custom/rfkill" = import ./modules/rfkill.nix { inherit pkgs mkScript; };
        "custom/nvidia-gpu" = import ./modules/nvidia-gpu.nix { inherit mkScript; };
        "custom/intel-gpu" = import ./modules/intel-gpu.nix { inherit pkgs mkScript; };
        "custom/player" = import ./modules/player.nix { inherit pkgs mkScript; };
        "custom/currentplayer" = import ./modules/currentplayer.nix { inherit pkgs mkScriptJson; };
        "custom/tx-net" = import ./modules/tx-net.nix { inherit mkScript; };
        "custom/rx-net" = import ./modules/rx-net.nix { inherit mkScript; };
        "custom/gpg-status" = import ./modules/gpg-status.nix {
          inherit
            mkScript
            mkScriptJson
            pkgs
            config
            lib
            ;
        };
      };
    };
  };
}
