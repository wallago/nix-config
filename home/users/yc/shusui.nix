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
    ./common.nix
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
