{ config, outputs, ... }: {
  imports = [
    ./boot.nix
    ./fail2ban.nix
    ./tpm.nix
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
    ./usb.nix
    ./systemd-initrd.nix
    ./upower.nix
    ../feat/yubikey
  ] ++ (builtins.attrValues outputs.nixosModules);

  services.automatic-timezoned.enable = true;

  system.stateVersion = "${config.system.nixos.release}";
}
