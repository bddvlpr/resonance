{
  lib,
  config,
  ...
}:
let
  inherit (lib) elem getExe mkIf;

  cfg = config.bowl.desktop;
in
{
  config = mkIf (cfg.enable && elem "hyprland" cfg.environments) {
    services.hypridle = {
      enable = true;
      settings = {
        listener = [
          {
            timeout = 5 * 60;
            on-timeout = "pidof hyprlock || ${getExe config.programs.hyprlock.package}";
          }
        ];
      };
    };
  };
}
