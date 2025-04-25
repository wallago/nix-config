{ ... }: {
  disko.devices = {
    disk.disk1 = {
      device = "/dev/nvme0n1";
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
              type = "lvm_pv";
              vg = "pool";
            };
          };
        };
      };
    };
    # LVM Volume Group configuration with multiple logical volumes
    lvm_vg = {
      pool = {
        type = "lvm_vg"; # Define volume group 'pool'
        lvs = {
          # Logical Volume for user home directories
          home = {
            size = "30%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
          # Logical Volume for the root filesystem
          root = {
            size = "50%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "defaults" ];
            };
          };
          # Logical Volume for system logs, databases, etc.
          var = {
            size = "20%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/var";
            };
          };
          # Logical Volume for swap partition
          swap = {
            size = "16G";
            content = { type = "swap"; };
          };
        };
      };
    };
  };
}
