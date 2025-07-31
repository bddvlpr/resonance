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
  xdg.portal = {
    enable = true;

    configPackages = lib.optionals (hasDesktop "hyprland") [
      pkgs.hyprland
    ];

    extraPortals = lib.optionals (hasDesktop "hyprland") [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
