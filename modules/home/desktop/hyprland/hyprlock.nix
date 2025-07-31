{
  lib,
  config,
  osConfig,
  ...
}:
let
  cfg = config.bowl.desktop;
in
{
  config = lib.mkIf (cfg.enable && lib.elem "hyprland" cfg.environments) {
    programs.hyprlock = {
      enable = true;
      settings = {
        general.grace = 30;

        auth = lib.mkIf osConfig.bowl.fingerprint.enable {
          "fingerprint:enabled" = true;
        };

        background = lib.mkForce {
          path = "screenshot";
          blur_passes = 1;
        };
      };
    };
  };
}
