{
  username,
  lib,
  pkgs,
  outputs,
  inputs,
  ...
}:
let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  imports = [
    (import ./home.nix { inherit username; })
    ../feat/cli

    ./nvim # -------> Vim text editor fork focused on extensibility and agility
    ./zellij.nix # -> Terminal workspace with batteries included
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  # ---

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
