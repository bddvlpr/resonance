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
    services.mako = {
      enable = true;
      settings.default-timeout = 5000;
    };
  };
}
