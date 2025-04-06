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
    ./font.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

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
