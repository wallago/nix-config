{
  username,
  lib,
  pkgs,
  config,
  outputs,
  inputs,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    (import ./home.nix { inherit username config; })
    ../feat/cli

    ./nvim # ------------> Vim text editor fork focused on extensibility and agility
    ./zellij.nix # ------> Terminal workspace with batteries included
    ./colorscheme.nix # -> Color scheme
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  # ---

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
