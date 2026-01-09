{
  device,
  swap,
}:
{
  devices = {
    disk.system = {
      type = "disk";
      inherit device;
      content = {
        type = "gpt";
        partitions = {
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
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              askPassword = true;
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes =
                  let
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  in
                  {
                    "/persist" = {
                      mountpoint = "/persist";
                      inherit mountOptions;
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      inherit mountOptions;
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = swap;
                    };
                  };
              };
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=16G"
        "defaults"
        "mode=755"
      ];
    };
  };
}
