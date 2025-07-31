{
  lib,
  config,
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
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.docker.enable {
      virtualisation.docker.enable = true;

      bowl.persist.entries = lib.mkIf cfg.docker.persist [
        { path = "/var/lib/docker"; }
      ];
    })
  ];
}
