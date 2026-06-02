{
  flake.nixosModules.hardwareCuttlefish =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/hardware/cpu/intel-npu.nix")
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot = {
        initrd = {
          kernelModules = [ ];
          availableKernelModules = [
            "xhci_pci"
            "thunderbolt"
            "nvme"
            "rtsx_pci_sdmmc"
          ];
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.npu.enable = true;
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
