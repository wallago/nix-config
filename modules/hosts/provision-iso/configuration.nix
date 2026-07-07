{ inputs, self, ... }:
{
  flake.nixosConfigurations.provisionIso = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      hostName = "provisionIso";
      inherit self;
    };
    modules = [
      self.nixosModules.configProvisionIso
    ];
  };

  flake.nixosModules.configProvisionIso = { lib, pkgs, ... }: {
    imports = [
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
      self.nixosModules.userOptions
      self.nixosModules.secretsProvisionIso
      self.nixosModules.wireguardClient
      self.nixosModules.secrets
      self.nixosModules.ssh
    ];

    preferences.user.name = "root";

    # installer is key-only root access; our ssh module's "no" would lock us out
    services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";

    # keyless ISO, inject the key by hand at provision time.
    sops.age = {
      sshKeyPaths = lib.mkForce [ ];
      keyFile = "/root/provision-iso.agekey";
    };

    # Passphrase-encrypted copy of that age key, baked into the image;
    # `provision-unlock` decrypts it at provision time, so a leaked ISO
    # stays useless without the passphrase.
    environment.etc."provision-iso.agekey.age".source = ./agekey.age;

    environment.systemPackages = [
      (pkgs.writeShellScriptBin "provision-unlock" ''
        set -euo pipefail

        # checks you're root.
        if [ "$(id -u)" -ne 0 ]; then
          echo "run as root: sudo provision-unlock" >&2
          exit 1
        fi

        # makes every file created afterwards readable by its owner only.
        umask 077

        # decrypts the passphrase-encrypted key baked into the image.
        # NOTE: a live ISO's root filesystem is a tmpfs in RAM layered 
        echo "Unlock needed to remote access"
        ${pkgs.age}/bin/age -d /etc/provision-iso.agekey.age > /root/provision-iso.agekey

        # re-runs the NixOS activation script of the current system.
        /run/current-system/activate

        # restarting brings wg1 up
        systemctl restart wg-quick-wg1.service
        ${pkgs.wireguard-tools}/bin/wg show wg1
      '')
    ];

    # boot → auto-login on tty1 → passphrase prompt → wg1 up
    programs.bash.loginShellInit = ''
      if [ "$(tty)" = /dev/tty1 ] && [ ! -e /root/provision-iso.agekey ]; then
        sudo provision-unlock
      fi
    '';

    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
