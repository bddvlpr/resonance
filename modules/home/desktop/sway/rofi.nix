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
    programs.rofi.enable = true;
  };
}
