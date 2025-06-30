{ lib, config, pkgs, inputs, outputs, ... }:
let username = "wallago";
in {
  imports = [
    ./common.nix
    (import ../../common { inherit username lib config pkgs outputs inputs; })
  ];
}
