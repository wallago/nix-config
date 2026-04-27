{ lib, config, pkgs, inputs, outputs, ... }:
let username = "nixos";
in {
  imports = [
    (import ../../common { inherit username lib config pkgs outputs inputs; })
  ];

  programs.git = {
    userName = "wallago";
    userEmail = "45556867+wallago@users.noreply.github.com";
  };
}
