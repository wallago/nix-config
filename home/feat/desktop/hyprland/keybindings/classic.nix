{ lib, ... }:
let
  workspaces = [
    "0"
    "1"
    "2"
    "3"
    "4"
    "5"
    "6"
    "7"
    "8"
    "9"
    "F1"
    "F2"
    "F3"
    "F4"
    "F5"
    "F6"
    "F7"
    "F8"
    "F9"
    "F10"
    "F11"
    "F12"
  ];
  directions = rec {
    left = "l";
    right = "r";
    up = "u";
    down = "d";
    h = left;
    l = right;
    k = up;
    j = down;
  };
in [
  "SUPERSHIFT,q,killactive"
  "SUPER,f,fullscreen,0"
  "SUPERSHIFT,l,workspace,e+1"
  "SUPERSHIFT,h,workspace,e-1"
  "SUPER,y,toggleswallow"
] ++ (map (n: "SUPER,${n},workspace,name:${n}") workspaces)
++ (map (n: "SUPERSHIFT,${n},movetoworkspace,name:${n}") workspaces)
++ (lib.mapAttrsToList (key: direction: "SUPER,${key},movefocus,${direction}")
  directions) ++ (lib.mapAttrsToList
    (key: direction: "SUPERALT,${key},swapwindow,${direction}") directions)
++ (lib.mapAttrsToList
  (key: direction: "SUPERCONTROL,${key},movewindow,${direction}") directions)
