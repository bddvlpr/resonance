{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.swayidle;
in {
  options.sysc.swayidle = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    services.swayidle = let
      swayidle = lib.getExe config.programs.swaylock.package;
    in {
      enable = true;

      timeouts = [
        {
          timeout = 60 * 5;
          command = swayidle;
        }
      ];
    };
  };
}
