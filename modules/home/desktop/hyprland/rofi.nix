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
    programs.rofi.enable = true;
  };
}
