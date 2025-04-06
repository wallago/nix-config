{
  username,
  lib,
  pkgs,
  outputs,
  ...
}:
{
  imports = [
    ./nix.nix
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
