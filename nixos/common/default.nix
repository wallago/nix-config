{ config, outputs, ... }: {
  imports = [
    ./boot.nix
    ./fail2ban.nix
    ./fish.nix
    ./grub.nix
    ./home.nix
    ./login.nix
    ./network.nix
    ./nix.nix
    ./nixpkgs.nix
    ./optin-persistence.nix
    ./sops.nix
    ./ssh.nix
    ./systemd-initrd.nix
    ./upower.nix
    ../feat/yubikey
  ] ++ (builtins.attrValues outputs.nixosModules);

  system.stateVersion = "${config.system.nixos.release}";
}
