{
  username,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./nix.nix
    (import ./home.nix { inherit username; })

    ./nvim
    ./zellij.nix
  ];

  # ---

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
