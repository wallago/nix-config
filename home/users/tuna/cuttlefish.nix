{
  lib,
  config,
  pkgs,
  inputs,
  outputs,
  ...
}:
let
  username = "tuna";
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
        outputs
        inputs
        ;
    })
  ];
}
