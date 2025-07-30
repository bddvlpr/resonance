{
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    types
    ;

  cfg = config.bowl.virtualisation;
in
{
  options.bowl.virtualisation = {
    docker = {
      enable = mkEnableOption "Docker engine";

      persist = mkOption {
        type = types.bool;
        default = true;
        description = "Automatically persist docker files.";
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.docker.enable {
      virtualisation.docker.enable = true;

      bowl.persist.entries = mkIf cfg.docker.persist [
        { path = "/var/lib/docker"; }
      ];
    })
  ];
}
