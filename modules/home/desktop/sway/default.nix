{
  lib,
  config,
  ...
}:
let
  inherit (lib) elem mkIf;

  cfg = config.bowl.desktop;
in
{
  imports = [
    ./rofi.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  config = mkIf (cfg.enable && elem "sway" cfg.environments) {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };
}
