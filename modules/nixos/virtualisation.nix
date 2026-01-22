{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.bowl.virtualisation;
in
{
  options.bowl.virtualisation = {
    docker = {
      enable = lib.mkEnableOption "Docker engine";

      persist = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Automatically persist docker files.";
      };
    };

    virtd = {
      enable = lib.mkEnableOption "Virtd";

      persist = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Automatically persist virtd files.";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.docker.enable {
      virtualisation.docker.enable = true;

      bowl.persist.entries = lib.mkIf cfg.docker.persist [
        { from = "/var/lib/docker"; }
      ];
    })
    (lib.mkIf cfg.virtd.enable {
      virtualisation.libvirtd = {
        enable = true;
        qemu.swtpm.enable = true;
      };

      networking.firewall.trustedInterfaces = [ "virbr0" ];

      environment.systemPackages = [ pkgs.virt-manager ];

      bowl.persist.entries = lib.mkIf cfg.virtd.persist [
        { from = "/var/lib/libvirt"; }
      ];
    })
  ];
}
