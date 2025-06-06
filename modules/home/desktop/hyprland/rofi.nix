{
  lib,
  config,
  ...
}: let
  inherit (lib) elem mkIf;

  cfg = config.bowl.desktop;
in {
  config = mkIf (cfg.enable && elem "hyprland" cfg.environments) {
    programs.rofi.enable = true;
  };
}
