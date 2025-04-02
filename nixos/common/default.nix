{ hostname, config, ... }:
{
  imports = [
    ./grub.nix
    ./home.nix
    (import ./network.nix { inherit hostname; })
    ./fish.nix
    ./ssh.nix
    ./nix.nix
  ];

  # ---

  services.upower.enable = true; # D-Bus service for power management.

  system.stateVersion = "${config.system.nixos.release}";

  environment.systemPackages = with pkgs; [
    sqlite # Self-contained, serverless, zero-configuration, transactional SQL database engine.
  ];
}
