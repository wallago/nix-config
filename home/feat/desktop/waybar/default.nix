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

        modules-left = [
          # [ "custom/menu" ]
          # ++ (lib.optionals swayCfg.enable [
          #   "sway/workspaces"
          #   "sway/mode"
          # ])
          # ++ (lib.optionals hyprlandCfg.enable [
          #   "hyprland/workspaces"
          #   "hyprland/submap"
          # ])
          # ++ [
          #   "custom/currentplayer"
          #   "custom/player"
          #   "custom/minicava"
        ];
        modules-center = [
          "cpu"
          "custom/gpu"
          "memory"
          "clock"
          # "custom/unread-mail"
        ];
        modules-right = [
          # "tray"
          # "custom/rfkill"
          "network"
          "pulseaudio"
          # "battery"
          # "custom/hostname"
        ];

        clock = import ./modules/clock.nix;
        cpu = import ./modules/cpu.nix;
        "custom/gpu" = import ./modules/gpu.nix { inherit mkScript; };
        memory = import ./modules/memory.nix;
        pulseaudio = import ./modules/pulseaudio.nix { inherit pkgs lib; };
        # battery = ./modules/battery.nix;
        network = import ./modules/network.nix;
      };
    };
  };
}
