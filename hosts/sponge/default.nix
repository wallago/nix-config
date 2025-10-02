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
    ../../nixos/users/wallago.nix
    ./hardware-configuration.nix
  ];

  disk.path = "/dev/nvme0n1";

  networking.hostName = "${hostname}";

  services.displayManager.gdm.banner = "go fuck your self";

  u2f.mappings = {
    wallago =
      "wallago:DMNXFaX1pYytbV6E8dJ2ukVYMGtleF/oWsyOeZAM87pYTFDQ4pOW8C04CcZjO8JzvwKQOqV6c+rmUxrhGrrcyQ==,rAo3pKpbfYgx/8qvxr1qve5GrYykcegOmVw6kf4JVG0t8n5dONyWwyS8xFD5qD0yBzw+mKOovB4BwX9tJ0BeGw==,es256,+presence";
  };

  boot = {
    loader.grub.useOSProber = true;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" "riscv64-linux" ];
  };
}
