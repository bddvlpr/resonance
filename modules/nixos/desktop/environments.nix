{
  self,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (self.lib) hasHome;
  inherit (lib) elem mkIf mkMerge;
in {
  config = mkMerge [
    (mkIf (hasHome config (envs: elem "hyprland" envs) ["bowl" "desktop" "environments"]) {
      services.displayManager.sessionPackages = [pkgs.hyprland];
    })
    # TODO: Sway and other WMs
  ];
}
