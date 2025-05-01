{ lib, pkgs, config, }:
let defaultApp = type: "${lib.getExe pkgs.handlr-regex} launch ${type}";
in [
  "SUPER,Return,exec,${defaultApp "x-scheme-handler/terminal"}"
  "SUPER,e,exec,${defaultApp "text/plain"}"
  "SUPER,b,exec,${defaultApp "x-scheme-handler/https"}"
] ++ import ./brightness.nix { inherit lib pkgs; }
++ import ./sound.nix { inherit lib pkgs; }
++ import ./screenshot.nix { inherit lib pkgs; }
++ import ./lock.nix { inherit lib config; }
++ import ./notification.nix { inherit lib config; }
++ import ./mediactl.nix { inherit lib config; }
++ import ./clipboard.nix { inherit lib config; }
++ import ./launcher.nix { inherit lib config; }
++ import ./classic.nix { inherit lib; }
++ import ./colorpicker.nix { inherit pkgs lib; }
