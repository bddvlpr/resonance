{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  hasDesktop =
    name:
    self.lib.hasHome config (envs: lib.elem name envs) [
      "bowl"
      "desktop"
      "environments"
    ];
in
{
  config = lib.mkMerge [
    (lib.mkIf (hasDesktop "hyprland") {
      services.displayManager.sessionPackages = [ pkgs.hyprland ];
    })
    (lib.mkIf (hasDesktop "sway") {
      services.displayManager.sessionPackages = [ pkgs.sway ];
    })
  ];
}
