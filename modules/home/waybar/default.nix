{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.waybar;
in {
  options.sysc.waybar = {
    enable = mkOption {
      type = types.bool;
      default = config.sysc.hyprland.enable;
      description = "Whether to enable Waybar.";
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      systemd.enable = true;
    };
  };
}
