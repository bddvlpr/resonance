{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.libvirtd;
in
{
  options.sysc.libvirtd = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable libvirtd.";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
      };
    };

    environment.systemPackages = [
      pkgs.virt-manager
    ];

    boot.binfmt.emulatedSystems = [
      "aarch64-linux"
    ];

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/lib/libvirt"
      ];
    };
  };
}
