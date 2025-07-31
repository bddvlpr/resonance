{
  lib,
  config,
  ...
}:
let
  cfg = config.bowl.desktop;
in
{
  config = lib.mkIf (cfg.enable && lib.elem "hyprland" cfg.environments) {
    services.hypridle = {
      enable = true;
      settings = {
        listener = [
          {
            timeout = 5 * 60;
            on-timeout = "pidof hyprlock || ${lib.getExe config.programs.hyprlock.package}";
          }
        ];
      };
    };
  };
}
