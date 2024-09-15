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
      swaylock = lib.getExe config.programs.swaylock.package;
      hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
    in {
      enable = true;

      timeouts = [
        {
          timeout = 60 * 3;
          command = "${swaylock} --grace 120";
        }
        {
          timeout = 60 * 5;
          command = "${hyprctl} dispatch dpms off";
          resumeCommand = "${hyprctl} dispatch dpms on";
        }
      ];
    };
  };
}
