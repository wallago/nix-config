{
  config,
  outputs,
  ...
}:
{
  imports = [
    ./boot.nix
    ./sops.nix
    ./grub.nix
    ./home.nix
    ./network.nix
    ./fish.nix
    ./ssh.nix
    ./nix.nix
    ./font.nix
    ./upower.nix
    ./nixpkgs.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  # ---

  system.stateVersion = "${config.system.nixos.release}";
}
