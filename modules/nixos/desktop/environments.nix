{
  self,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (self.lib) hasHome;
  inherit (lib) elem mkIf mkMerge;

  hasDesktop = name: hasHome config (envs: elem name envs) ["bowl" "desktop" "environments"];
in {
  config = mkMerge [
    (mkIf (hasDesktop "hyprland") {
      services.displayManager.sessionPackages = [pkgs.hyprland];
    })
    (mkIf (hasDesktop "sway") {
      services.displayManager.sessionPackages = [pkgs.sway];
    })
  ];
}
