{ config, outputs, ... }: {
  imports = [
    ./boot.nix
    ./ssh.nix
    ./nix.nix
    ./sops.nix
    ./grub.nix
    ./home.nix
    ./fish.nix
    ./login.nix
    ./upower.nix
    ./nixpkgs.nix
    ./network.nix
    ./systemd-initrd.nix
    ./optin-persistence.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  # ---

  system.stateVersion = "${config.system.nixos.release}";
}
