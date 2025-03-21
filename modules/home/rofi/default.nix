{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.rofi;
in
{
  options.sysc.rofi = {
    enable = mkOption {
      type = types.bool;
      default = config.sysc.hyprland.enable;
      description = "Whether to enable Rofi.";
    };
  };

  config = mkIf cfg.enable {
    programs.rofi.enable = true;
  };
}
