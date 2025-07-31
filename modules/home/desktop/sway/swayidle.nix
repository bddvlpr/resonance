{
  lib,
  config,
  ...
}:
let
  cfg = config.bowl.desktop;
in
{
  config = lib.mkIf (cfg.enable && lib.elem "sway" cfg.environments) {
    services.swayidle = {
      enable = true;

      timeouts = [
        {
          timeout = 60 * 4;
          command = lib.getExe config.programs.swaylock.package;
        }
      ];
    };
  };
}
