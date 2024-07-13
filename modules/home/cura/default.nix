{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.cura;
in {
  options.sysc.cura = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable Cura.";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [cura];

      persistence."/persist/home/bddvlpr".directories = [
        ".config/cura"
        ".local/share/cura"
      ];
    };
  };
}
