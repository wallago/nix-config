{
  hostname,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./boot.nix
    ./grub.nix
    ./home.nix
    (import ./network.nix { inherit hostname; })
    ./fish.nix
    ./ssh.nix
    ./nix.nix
    #./nvim.nix
  ];

  # ---

  services.upower.enable = true; # D-Bus service for power management.

  system.stateVersion = "${config.system.nixos.release}";
}
