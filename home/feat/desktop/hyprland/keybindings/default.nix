{
  lib,
  pkgs,
  config,
  ...
}:
let
  defaultApp = type: "${lib.getExe pkgs.handlr-regex} launch ${type}";
in
[
  "SUPER,Return,exec,${defaultApp "x-scheme-handler/terminal"}"
  "SUPER,e,exec,${defaultApp "text/plain"}"
  "SUPER,b,exec,${defaultApp "x-scheme-handler/https"}"
]
++ import = ./brightness.nix;
++ import = ./sound.nix;
++ import = ./screenshot.nix;
++ import = ./lock.nix;
++ import = ./notification.nix;
++ import = ./mediactl.nix;
++ import = ./clipboard.nix;
++ import = ./launcher.nix;
