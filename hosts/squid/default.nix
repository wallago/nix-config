{ inputs, ... }:
let hostname = "squid";
in {
  imports = [
    inputs.disko.nixosModules.disko
    ../../nixos/common
    ../../nixos/feat/desktop
    ../../nixos/feat/gpu/intel.nix
    ../../nixos/feat/tlp.nix
    ../../nixos/feat/peripherals.nix
    ../../nixos/feat/disko-configuration.nix
    ../../nixos/feat/bluetooth.nix
    ../../nixos/feat/sound.nix
    ../../nixos/feat/printer.nix
    ../../nixos/feat/docker.nix
    ../../nixos/feat/steam-gamescope-session.nix
    ../../nixos/feat/heroic-gamescope-session.nix
    ../../nixos/feat/regreet.nix
    ../../nixos/feat/bambulab.nix
    ../../nixos/users/wallago.nix
    ./hardware-configuration.nix
  ];

  disk.path = "/dev/nvme0n1";

  networking.hostName = "${hostname}";

  services.displayManager.gdm.banner = "go fuck your self";

  boot.binfmt.emulatedSystems =
    [ "aarch64-linux" "i686-linux" "riscv64-linux" ];

  u2f.mappings = {
    wallago =
      "wallago:N+0872p6RkLLzzpzZer5JZ+c7esDiNQye/jy7//fHJw5FXEGYNCzStpHmPJxVaVcQwhQLUjjBWkruMYi3w763g==,Yw95jmoJcL5EC1OjE3IUoBFOnPhsnC2LTyCj7ZxKV5aMklH0L9NgDSNAdOOfH7gw1LDBTzwPYpXkrQ/8IzuLpQ==,PKTj3cs5Yvsga/QYL1Jt7uZC8beCD0gEwLXX1kVSqUO5yMcxZ/wf261ngK34uQ0MXpUyvX1nLRVhbbRSM6HskA==,QTk3ammRzhMj0dbGfJsRfjcyQ0/iv0fE3JmTpLlR3Ahqd3B5G1D8xvOOZLxcA6zsEPYKbjTyDBeLA9zrB8QgKQ==,es256,+presence";
  };

  services.logind = {
    settings.Login = {
      LidSwitch = "suspend";
      LidSwitchExternalPower = "lock";
      HandlePowerKeyLongPress = "poweroff";
      HandlePowerKey = "suspend";
    };
  };
}
