{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (self.lib) hasHome;
  inherit (lib) elem optionals;

  hasDesktop =
    name:
    hasHome config (envs: elem name envs) [
      "bowl"
      "desktop"
      "environments"
    ];
in
{
  xdg.portal = {
    enable = true;

    configPackages = optionals (hasDesktop "hyprland") [
      pkgs.hyprland
    ];

    extraPortals = optionals (hasDesktop "hyprland") [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
