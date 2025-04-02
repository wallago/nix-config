{
  username,
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./nix.nix
    (import ./home.nix { inherit username; })
    # ./nvim.nix
  ];

  # ---

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
