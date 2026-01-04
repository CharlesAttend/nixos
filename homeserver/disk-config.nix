{
  networking.hostId = "d61ca469"; # Madatory for ZFS
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-CT500P5SSD8_21022C643129";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              size = "2G";
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
                # extraArgs = [ "-f" ]; # Override existing partition
                subvolumes = {
                  # Subvolume name is different from mountpoint
                  "/nixroot" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/swap" = {
                    mountpoint = "/swap";
                    swap = {
                      swapfile.size = "16G";
                    };
                  };
                };
              };
            };
          };
        };
      };

      data = {
        type = "disk";
        device = "/dev/disk/by-id/ata-WDC_WD60EFPX-68C5ZN0_WD-WX12DA5H515K";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "data";
              };
            };
          };
        };
      };

      data2 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-WDC_WD60EFPX-68C5ZN0_WD-WX12DA5H5NE9";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "data";
              };
            };
          };
        };
      };

      backup = {
        type = "disk";
        device = "/dev/disk/by-id/ata-WDC_WD122KFBX-68CCHN0_WD-B00R76TD";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "backup";
              };
            };
          };
        };
      };
    };

    zpool = {
      data = {
        type = "zpool";
        mode = "mirror";
        rootFsOptions = {
          compression = "zstd";
          canmount = "off";
        };

        datasets = {
          data = {
            type = "zfs_fs";
            mountpoint = "/mnt/data";
          };
        };
      };

      backup = {
        type = "zpool";
        rootFsOptions = {
          compression = "zstd";
          canmount = "off";
        };
        datasets = {
          data = {
            type = "zfs_fs";
            mountpoint = "/mnt/backup";
          };
        };
      };
    };
  };
}
