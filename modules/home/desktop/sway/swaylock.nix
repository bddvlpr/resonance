{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) elem mkIf;

  cfg = config.bowl.desktop;
in {
  config = mkIf (cfg.enable && elem "sway" cfg.environments) {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
    };
  };
}
