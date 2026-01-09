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
    services.hyprpaper = {
      enable = true;
      settings.splash = false;
    };
  };
}
