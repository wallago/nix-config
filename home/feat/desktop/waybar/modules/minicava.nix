{
  pkgs,
  lib,
  mkScript,
  ...
}:
{
  exec = mkScript { script = lib.getExe pkgs.minicava; };
  "restart-interval" = 5;
}
