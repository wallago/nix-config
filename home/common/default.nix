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
    ../feat/nvim
    ./colorscheme.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  # ---

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
