{
  self,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (self.lib) hasHome;
  inherit (lib) mkIf;
in {
  config = mkIf (hasHome config (v: v == "hyprland") ["bowl" "desktop" "environment"]) {
    services.displayManager.sessionPackages = [pkgs.hyprland];
  };
}
