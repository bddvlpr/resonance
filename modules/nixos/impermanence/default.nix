{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (inputs.impermanence.nixosModules) impermanence;
  inherit (lib) mkOption types;

  cfg = config.sysc.impermanence;
in {
  imports = [impermanence];

  options.sysc.impermanence = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable tmpfs-as-root.";
    };
  };

  config = {
    programs.fuse.userAllowOther = true;
    environment.persistence."/persist" = {
      enable = cfg.enable;
      directories = [
        "/etc/nixos"
        "/etc/ssh"
        "/var/log"
      ];
    };
  };
}
