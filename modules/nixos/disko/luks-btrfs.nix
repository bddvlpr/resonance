{
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkIf
    mkMerge
    mkOption
    types
    ;

  cfg = config.sysc.disko.luks-btrfs;
  impermanent = config.sysc.impermanence.enable;
in
{
  options.sysc.disko.luks-btrfs = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Use this disk layout.";
    };

    device = mkOption {
      type = with types; nullOr str;
      description = "The target device to install to.";
    };
  };

  config = mkIf cfg.enable {
    disko.devices.disk = {
      system = {
        type = "disk";
        device = cfg.device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
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
                  subvolumes = mkMerge [
                    (mkIf impermanent {
                      "/persist" = {
                        mountpoint = "/persist";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                    })
                    (mkIf (!impermanent) {
                      "/root" = {
                        mountpoint = "/";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                    })
                    {
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/swap" = {
                        mountpoint = "/swap";
                        swap.swapfile.size = "16G";
                      };
                    }
                  ];
                };
              };
            };
          };
        };
      };
    };

    disko.devices.nodev = mkIf impermanent {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [ "mode=755" ];
      };
    };

    fileSystems = mkIf impermanent {
      "/nix".neededForBoot = true;
      "/persist".neededForBoot = true;
    };
  };
}
