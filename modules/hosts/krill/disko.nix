{ inputs, self, ... }:
{
  flake.nixosModules.diskoKrill = {
    imports = [
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.hostKrill
    ];
    fileSystems."/persist".neededForBoot = true;
    fileSystems."/home".neededForBoot = true;
  };

  flake.diskoConfigurations.hostKrill = {
    disko.devices = {
      disk.disk1 = {
        device = "/dev/disk/by-id/nvme-Samsung_SSD_980_500GB_S78GNL0XA17983W";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            # BIOS Boot Partition for legacy GRUB (optional)
            boot = {
              name = "boot";
              size = "2M";
              type = "EF02";
            };
            # EFI System Partition (ESP) for UEFI systems
            esp = {
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" ];
                  };
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@swap" = {
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/swap";
                    swap.swapfile = {
                      size = "16G";
                      path = "swapfile";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
