{
  lib,
  config,
  ...
}: let
  inherit (lib) elem getExe mkIf;

  cfg = config.bowl.desktop;
in {
  config = mkIf (cfg.enable && elem "sway" cfg.environments) {
    services.swayidle = {
      enable = true;

      timeouts = [
        {
          timeout = 60 * 4;
          command = getExe config.programs.swaylock.package;
        }
      ];
    };
  };
}
