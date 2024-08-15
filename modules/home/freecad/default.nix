{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.freecad;
in {
  options.sysc.freecad = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable FreeCAD.";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [freecad];
      persistence."/persist/home/bddvlpr".directories = [
        ".local/share/FreeCAD"
        ".config/FreeCAD"
      ];
    };
  };
}
