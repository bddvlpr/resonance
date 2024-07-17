{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.godot;
in {
  options.sysc.godot = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable godot.";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = [pkgs.godot_4];
      persistence."/persist/home/bddvlpr".directories = [
        ".config/godot"
      ];
    };
  };
}
