{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (config.bowl.desktop.environment == "hyprland") {
    services.displayManager.sessionPackages = [pkgs.hyprland];
  };
}
