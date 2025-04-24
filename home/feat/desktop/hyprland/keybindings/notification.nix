{
  lib,
  config,
}:
let
  makoctl = lib.getExe' config.services.mako.package "makoctl";
in
lib.optionals config.services.mako.enable [
  "SUPER,w,exec,${makoctl} dismiss"
  "SUPERSHIFT,w,exec,${makoctl} restore"
]
