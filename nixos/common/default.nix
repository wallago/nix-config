{ outputs, ... }: {
  imports = [
    ./boot.nix
    ./fail2ban.nix
    ./gamemode.nix
    ./tpm.nix
    ./fish.nix
    ./grub.nix
    ./home.nix
    ./login.nix
    ./network.nix
    ./nix.nix
    ./local.nix
    ./nixpkgs.nix
    ./optin-persistence.nix
    ./sops.nix
    ./ssh.nix
    ./usb.nix
    ./systemd-initrd.nix
    ./keyring.nix
    ./upower.nix
    ../feat/yubikey.nix
    ../../yubikey
  ] ++ (builtins.attrValues outputs.nixosModules)
    ++ (builtins.attrValues outputs.nixosAndHomeManagerModules);

  system.stateVersion = "25.05";
}
