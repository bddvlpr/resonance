{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.swaylock;
in {
  options.sysc.swaylock = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.swaylock = {
      enable = true;

      package = pkgs.swaylock-effects;

      settings = {
        font = config.stylix.fonts.sansSerif.name;
        screenshots = true;
        clock = true;
        show-failed-attempts = true;
        indicator-idle-visible = true;
        effect-blur = "8x5";
      };
    };
  };
}
