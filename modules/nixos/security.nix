{
  lib,
  self,
  config,
  ...
}: let
  inherit (self.lib) hasHome;
  inherit (lib) elem mkIf;
in {
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  security.pam.services.hyprlock =
    mkIf (hasHome config (envs: elem "hyprland" envs) ["bowl" "desktop" "environments"]) {};
}
