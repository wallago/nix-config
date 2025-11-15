{ inputs, ... }:
let hostname = "sponge";
in {
  imports = [
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/feat/desktop
    ../../nixos/feat/gpu/nvidia.nix
    ../../nixos/feat/peripherals.nix
    ../../nixos/feat/disko-configuration.nix
    ../../nixos/feat/sound.nix
    ../../nixos/feat/bluetooth.nix
    ../../nixos/feat/docker.nix
    ../../nixos/feat/printer.nix
    ../../nixos/feat/steam-gamescope-session.nix
    ../../nixos/feat/heroic-gamescope-session.nix
    ../../nixos/feat/bambulab.nix
    ../../nixos/users/wallago.nix
    ./hardware-configuration.nix
  ];

  disk.path = "/dev/nvme0n1";

  networking.hostName = "${hostname}";

  services.displayManager.gdm.banner = "go fuck your self";

  u2f.mappings = {
    wallago =
      "wallago:L1GqY9QUd8xiKdKUePH7RDztNBzEvwHRf7FlKxnwWUrpcT5zgQ21gi1JcNMbDHZyp+TgK8j8YQzPADAIY2IfiQ==,RohvT7hv8Wc6SvITW6xvthdCDGNLWhUl50pzu2o2TMi65qPZCurA9x2KagbfKr0p9GA4YkSGSJtBTefGe941kA==,es256,+presenc";
  };

  boot = {
    loader.grub.useOSProber = true;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" "riscv64-linux" ];
  };
}
