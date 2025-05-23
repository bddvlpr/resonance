{
  lib,
  config,
  ...
}: let
  inherit (lib) elem mkIf;

  cfg = config.bowl.desktop;
in {
  config = mkIf (cfg.enable && elem "hyprland" cfg.environments) {
    services.mako = {
      enable = true;
      settings.defaultTimeout = 5 * 1000;
    };
  };
}
