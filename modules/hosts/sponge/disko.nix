{ inputs, ... }:
{
  flake.diskoConfigurations.hostSponge = {
    imports = [ inputs.disko.nixosModules.disko ];

    # Tell systemd these mounts must be ready early in boot.
    # /persist holds machine-id, ssh host keys, and sops keys — without
    # this flag, services that need them at boot will fail.
    fileSystems."/persist".neededForBoot = true;

    disko.devices = {
      disk.main = {
        device = "/dev/disk/by-id/nvme-Corsair_MP600_GS_2305802200013241002";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            # BIOS boot partition. Only used if you ever fall back to legacy
            # GRUB; harmless on UEFI. 1 MiB is enough.
            boot = {
              size = "1M";
              type = "EF02";
              priority = 1;
            };

            # EFI System Partition. systemd-boot lives here.
            esp = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            # Dedicated swap partition. More predictable than swap-on-btrfs.
            # resumeDevice = true wires up hibernation.
            swap = {
              size = "16G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };

            # Everything else: btrfs with subvolumes for impermanence.
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"
                  "-L"
                  "nixos"
                ];
                subvolumes = {
                  # Root subvolume — gets wiped/rolled back on every boot
                  # via your impermanence activation script.
                  "@root" = {
                    mountpoint = "/";
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

                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };

                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };

                  # Snapshots of @root live here. Used for impermanence
                  # rollback — see services.btrbk or your activation script.
                  "@snapshots" = {
                    mountpoint = "/.snapshots";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
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
