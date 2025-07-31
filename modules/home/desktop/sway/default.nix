{
  lib,
  config,
  ...
}:
let
  cfg = config.bowl.desktop;
in
{
  imports = [
    ./rofi.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  config = lib.mkIf (cfg.enable && lib.elem "sway" cfg.environments) {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };
}
