{
  lib,
  config,
  ...
}: let
  inherit (lib) elem filter forEach getExe mkIf;

  cfg = config.bowl.desktop;
in {
  config = mkIf (cfg.enable && elem "hyprland" cfg.environments) {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
        };

        monitor =
          [
            ", highres, auto, 1"
          ]
          ++ (forEach config.bowl.desktop.monitors ({
            enable,
            name,
            width,
            height,
            refreshRate,
            x,
            y,
            scale,
            ...
          }:
            if enable
            then "${name}, ${toString width}x${toString height}@${toString refreshRate}, ${toString x}x${toString y}, ${toString scale}"
            else "${name}, disabled"));

        workspace = let
          enabledWorkspaces = filter ({
            enable,
            workspace,
            ...
          }:
            enable && workspace != null)
          config.bowl.desktop.monitors;
        in
          forEach enabledWorkspaces ({
            name,
            workspace,
            ...
          }: "name:${toString workspace}, monitor:${name}");
      };
    };

    services = {
      hyprpaper.enable = true;
      hypridle = {
        enable = true;
        settings = {
          listener = [
            {
              timeout = 5 * 60;
              on-timeout = getExe config.programs.hyprlock.package;
            }
          ];
        };
      };
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        general.grace = 30;
      };
    };
  };
}
