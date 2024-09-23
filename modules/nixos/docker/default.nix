{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.docker;
in {
  options.sysc.docker = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Docker and Docker engine.";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;

    environment.persistence."/persist".directories = [
      "/var/lib/docker"
    ];
  };
}
