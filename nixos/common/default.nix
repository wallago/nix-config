{
  config,
  outputs,
  ...
}:
{
  imports = [
    ./boot.nix
    ./grub.nix
    ./home.nix
    ./network.nix
    ./fish.nix
    ./ssh.nix
    ./nix.nix
  ];

  nixpkgs = {
    overlays = outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  # ---

  services.upower.enable = true; # D-Bus service for power management.

  system.stateVersion = "${config.system.nixos.release}";
}
