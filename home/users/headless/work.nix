{
  lib,
  config,
  pkgs,
  inputs,
  outputs,
  ...
}:
let
  username = "work";
in
{
  imports = [
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
    ../../feat/pass.nix
    ./common.nix
  ];
}
