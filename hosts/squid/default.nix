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
      "wallago:Ge4frHnYZmClZvjgXUiiSkUd2cubTHFrVQDe4AHUXe7yet0Yw2pkqSc9ZL7jiMQ1IhtfJikxRtWjCNMIFgDu3Q==,ks5uwCN0k7KGqDP5Qbwxl4hM3m/0RioASk7B6n+vXqXPhJTy+s1PgtbhLD6KYOmu2Lyjw84enH/Cg79zruOOug==,es256,+presence";
  };

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    powerKey = "suspend";
    powerKeyLongPress = "poweroff";
  };
}
