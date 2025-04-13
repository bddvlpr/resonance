{
  lib,
  config,
  ...
}: let
  inherit (lib) elem mkIf;

  cfg = config.bowl.desktop;
in {
  config = mkIf (cfg.enable && elem "sway" cfg.environments) {
    wayland.windowManager.sway = {
      enable = true;
    };
  };
}
