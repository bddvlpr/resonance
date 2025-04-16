{
  lib,
  config,
  ...
}: let
  inherit (lib) elem filter forEach mkIf;

  cfg = config.bowl.desktop;
in {
  config = mkIf (cfg.enable && elem "hyprland" cfg.environments) {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
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
  };
}
