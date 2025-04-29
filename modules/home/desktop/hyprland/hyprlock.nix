{
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib) elem mkForce mkIf;

  cfg = config.bowl.desktop;
in {
  config = mkIf (cfg.enable && elem "hyprland" cfg.environments) {
    programs.hyprlock = {
      enable = true;
      settings = {
        general.grace = 30;

        auth = mkIf osConfig.bowl.fingerprint.enable {
          "fingerprint:enabled" = true;
        };

        background = mkForce {
          path = "screenshot";
          blur_passes = 1;
        };
      };
    };
  };
}
