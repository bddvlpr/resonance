{
  lib,
  config,
  ...
}:
let
  cfg = config.bowl.desktop;
in
{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./mako.nix
    ./rofi.nix
    ./waybar.nix
  ];

  config = lib.mkIf (cfg.enable && lib.elem "hyprland" cfg.environments) {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
        };

        monitor = [
          ", highres, auto, 1"
        ]
        ++ (lib.forEach config.bowl.desktop.monitors (
          {
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
          if enable then
            "${name}, ${toString width}x${toString height}@${toString refreshRate}, ${toString x}x${toString y}, ${toString scale}"
          else
            "${name}, disabled"
        ));

        workspace =
          let
            enabledWorkspaces = lib.filter (
              {
                enable,
                workspace,
                ...
              }:
              enable && workspace != null
            ) config.bowl.desktop.monitors;
          in
          lib.forEach enabledWorkspaces (
            {
              name,
              workspace,
              ...
            }:
            "name:${toString workspace}, monitor:${name}"
          );
      };
    };
  };
}
