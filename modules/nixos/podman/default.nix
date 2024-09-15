{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.podman;
in {
  options.sysc.podman = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable podman.";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.podman.enable = true;

    environment.persistence."/persist".directories = [
      "/var/lib/containers"
    ];
  };
}
