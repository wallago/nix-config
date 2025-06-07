{ lib, config, pkgs, inputs, outputs, ... }:
let username = "nixos";
in {
  imports = [
    (import ../../common { inherit username lib config pkgs outputs inputs; })
  ];
}
