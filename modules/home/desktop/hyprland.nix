{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (config.bowl.desktop.environment == "hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
    };
  };
}
