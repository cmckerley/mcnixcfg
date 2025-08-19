{
  disko.devices.disk.main = {
    type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              # name = "ESP";
              size = "1G";
              type = "EF00";
              priority = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              # name = "swap";
              size = "8G";
              priority = 2;
              content = {
                type = "swap";
                randomEncryption = true;
              };
            };
            root = {
              # name = "root";
              size = "100%";
              priority = 3;
              content = {
                type = "btrfs";
                subvolumes = {
                      "@" = { };
                      "@/root" = {
                        mountpoint = "/";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                      "@/home" = {
                        mountpoint = "/home";
                        mountOptions = [ "compress=zstd" ];
                      };
                      "@/nix" = {
                        mountpoint = "/nix";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                      "@/persist" = {
                        mountpoint = "/persist";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                      "@/var-lib" = {
                        mountpoint = "/var/lib";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                      "@/var-log" = {
                        mountpoint = "/var/log";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                      "@/var-tmp" = {
                        mountpoint = "/var/tmp";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                    };
                  };
                };
             };
            };
};
}
