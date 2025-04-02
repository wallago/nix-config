{
  lib,
  config,
  pkgs,
  ...
}:
let
  username = "yc";
in
{
  imports = [
    (import ../../common {
      inherit
        username
        lib
        config
        pkgs
        ;
    })
    ../../feat/desktop
  ];
}
